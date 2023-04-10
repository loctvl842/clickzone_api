<?php
class Product
{
  private $conn;
  private $table = "products";

  // user properties
  public $id;
  public $name;
  public $image_url;
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
    $query = "INSERT INTO $this->table(name, image_url, price, old_price, description)
              VALUES (:name, :image_url, :price, :old_price, :description)";
    $stmt = $this->conn->prepare($query);
    $this->name = htmlspecialchars(strip_tags($this->name));
    $this->image_url = htmlspecialchars(strip_tags($this->image_url));

    $data = array(
      "name" => $this->name,
      "image_url" => $this->image_url,
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

  public function getBy_pageNumber($page, $num)
  {
    $start_idx = $page * $num;
    $query = "SELECT * FROM $this->table LIMIT $start_idx, $num";
    $stmt = $this->conn->prepare($query);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    return $result;
  }

  public function searchBy_id()
  {
    $query = "SELECT * FROM $this->table WHERE $this->table.id = :productId";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("productId", $this->id);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
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
    SET name = :name, image_url = :image_url, price = :price, old_price = :old_price, description = :description
    WHERE id = :id";

    $stmt = $this->conn->prepare($query);
    $data = array(
      "id" => $this->id,
      "name" => $this->name,
      "image_url" => $this->image_url,
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
}
