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
    return $stmt->execute($data);
  }

  public function getByPage($page, $num)
  {
    $start_idx = $page * $num;
    $query = "SELECT * FROM $this->table LIMIT $start_idx, $num";
    $stmt = $this->conn->prepare($query);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    return $result;
  }
}
