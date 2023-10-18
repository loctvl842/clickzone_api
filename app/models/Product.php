<?php
class Product
{
  private $conn;
  private $table = "product";

  // user properties
  public $id;
  public $name;
  public $image_url;
  public $category_id;
  public $price;
  public $old_price;
  public $description;

  // Constructor with DB
  public function __construct($conn)
  {
    $this->conn = $conn;
  }

  public function add()
  {
    $query = "INSERT INTO $this->table(name, image_url, category_id, price, old_price, description)
              VALUES (:name, :image_url, :category_id, :price, :old_price, :description)";
    $stmt = $this->conn->prepare($query);
    $this->name = htmlspecialchars(strip_tags($this->name));
    $this->image_url = htmlspecialchars(strip_tags($this->image_url));

    $data = array(
      "name" => $this->name,
      "image_url" => $this->image_url,
      "category_id" => $this->category_id,
      "price" => $this->price,
      "old_price" => $this->old_price,
      "description" => $this->description
    );
    $stmt->execute($data);

    // Get the ID of the last inserted row
    $lastProductId = $this->conn->lastInsertId();
    $this->id = $lastProductId;

    $result = $this->searchBy_id($lastProductId);
    return $result;
  }

  public function getBy_pageNumber($sort, $page, $num, $searchString = null)
  {
    $query = "
SELECT
  p.id,
  p.name,
  p.image_url,
  p.category_id,
  c.name as category_name,
  p.price,
  p.old_price,
  p.description,
  p.created_at,
  p.modified_at
FROM $this->table as p
LEFT JOIN category as c ON p.category_id = c.id
";
    // filter by category
    if ($this->category_id) {
      $query .= "
JOIN (
  SELECT
    parent.id as id,
    parent.name as name,
    child.id as child_id,
    child.name as child_name
  FROM category as parent
  LEFT JOIN category_relationship as r ON parent.id = r.parent_id
  LEFT JOIN category as child ON r.child_id = child.id
  WHERE parent.id = :categoryId
) as r ON r.id = p.category_id || r.child_id = p.category_id
";
    }
    if ($searchString) $query .= "
WHERE LOWER(p.name) LIKE :searchString || LOWER(p.id) LIKE :searchString
";

    // sort
    if ($sort === 0) {
      $query .= " ORDER BY modified_at DESC";
    } elseif ($sort === 1) {
      $query .= " ORDER BY price";
    } elseif ($sort === 2) {
      $query .= " ORDER BY price DESC";
    } else {
      throw new Exception("There is no sort: " . $sort);
    }
    // get by page
    $start_idx = $page * $num;
    $query .= " LIMIT $start_idx, $num";

    $stmt = $this->conn->prepare($query);
    if ($this->category_id) $stmt->bindParam("categoryId", $this->category_id);
    if ($searchString) $stmt->bindValue(":searchString", "%$searchString%", PDO::PARAM_STR);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    return $result;
  }

  public function searchBy_id()
  {
    $query = "
SELECT 
  p.id,
  p.name,
  p.image_url,
  p.category_id,
  c.name as category_name,
  p.price,
  p.old_price,
  p.description,
  p.created_at,
  p.modified_at
FROM $this->table as p
LEFT JOIN category as c ON p.category_id = c.id
WHERE p.id = :productId";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("productId", $this->id);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $result["price"] = floatval($result["price"]);
    $result["old_price"] = floatval($result["old_price"]);
    return $result;
  }

  public function removeBy_id()
  {
    $query = "DELETE FROM $this->table WHERE id = :productId";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("productId", $this->id);
    $stmt->execute();
    if ($stmt->rowCount() == 0) {
      throw new Exception("There is no product with id: $this->id.");
    }
  }

  public function editBy_id()
  {
    $query = "UPDATE $this->table
    SET name = :name, image_url = :image_url, category_id = :category_id, price = :price, old_price = :old_price, description = :description
    WHERE id = :id";

    $stmt = $this->conn->prepare($query);
    $data = array(
      "id" => $this->id,
      "name" => $this->name,
      "image_url" => $this->image_url,
      "category_id" => $this->category_id,
      "price" => $this->price,
      "old_price" => $this->old_price,
      "description" => $this->description
    );
    $stmt->execute($data);

    // Get the ID of the last inserted row
    $lastProductId = $this->id;

    $result = $this->searchBy_id($lastProductId);
    return $result;
  }

  public function count($searchString)
  {
    $query = "SELECT COUNT(*) AS product_count FROM $this->table as p";
    if ($this->category_id) {
      $query .= "
JOIN (
  SELECT
    parent.id as id,
    parent.name as name,
    child.id as child_id,
    child.name as child_name
  FROM category as parent
  LEFT JOIN category_relationship as r ON parent.id = r.parent_id
  LEFT JOIN category as child ON r.child_id = child.id
  WHERE parent.id = :categoryId
) as r ON r.id = p.category_id || r.child_id = p.category_id
";
    }
    if ($searchString) $query .= "
WHERE LOWER(p.name) LIKE :searchString
";

    $stmt = $this->conn->prepare($query);

    if ($this->category_id) $stmt->bindParam("categoryId", $this->category_id);
    if ($searchString) $stmt->bindValue(":searchString", "%$searchString%", PDO::PARAM_STR);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    return $result;
  }

  public function getBy_searchString($sort, $page, $num, $searchString)
  {
    $query = "
SELECT
  p.id,
  p.name,
  p.image_url,
  p.category_id,
  c.name as category_name,
  p.price,
  p.old_price,
  p.description,
  p.created_at,
  p.modified_at
FROM $this->table as p
LEFT JOIN category as c ON p.category_id = c.id
WHERE LOWER(p.name) LIKE :searchString
";

    // sort
    if ($sort === 0) {
      $query .= " ORDER BY modified_at DESC";
    } elseif ($sort === 1) {
      $query .= " ORDER BY price";
    } elseif ($sort === 2) {
      $query .= " ORDER BY price DESC";
    } else {
      throw new Exception("There is no sort: " . $sort);
    }
    // get by page
    $start_idx = $page * $num;
    $query .= " LIMIT $start_idx, $num";

    $stmt = $this->conn->prepare($query);
    $stmt->bindValue(":searchString", "%$searchString%", PDO::PARAM_STR);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    return $result;
  }
}
