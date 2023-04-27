<?php
class Category
{
  private $conn;
  private $table = "category";

  public $id;
  public $name;

  // Constructor with DB
  public function __construct($conn)
  {
    $this->conn = $conn;
  }

  public function getAll()
  {
    $query = "
SELECT
  parent.id as id,
  parent.name as name,
  child.id as child_id,
  child.name as child_name
FROM category as parent
LEFT JOIN category_relationship as r ON parent.id = r.parent_id
LEFT JOIN category as child ON r.child_id = child.id
";
    $stmt = $this->conn->prepare($query);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    return $result;
  }

  public function getBy_id()
  {
    $query = "
SELECT
  parent.id as id,
  parent.name as name,
  child.id as child_id,
  child.name as child_name
FROM $this->table as parent
LEFT JOIN category_relationship as r ON parent.id = r.parent_id
LEFT JOIN category as child ON r.child_id = child.id
WHERE parent.id = :categoryId
";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("categoryId", $this->id);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    return $result;
  }

  public function search_parentId()
  {
    $query = "
SELECT
  c.id,
  cr.parent_id
FROM
$this->table AS c
LEFT JOIN category_relationship AS cr
ON cr.child_id = c.id
WHERE
c.id = :categoryId
";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("categoryId", $this->id);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    return $result['parent_id'] === null ? $result['id'] : $result['parent_id'];
  }
}
