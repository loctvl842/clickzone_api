<?php
class Order_details
{
  private $conn;
  private $table = "order_details";

  public $id;
  public $user_id;
  public $total;

  // Constructor with DB
  public function __construct($conn)
  {
    $this->conn = $conn;
  }

  public function searchBy_id()
  {
    $query = "SELECT * FROM $this->table WHERE id = :orderDetailsId";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("orderDetailsId", $this->id);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $result['total'] = floatval($result['total']);
    return $result;
  }

  public function add()
  {
    $query = "INSERT INTO $this->table(user_id, total)
              VALUES (:userId, :total)";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("userId", $this->user_id);
    $stmt->bindParam("total", $this->total);
    $stmt->execute();

    $lastProductId = $this->conn->lastInsertId();
    $this->id = $lastProductId;
    $result = $this->searchBy_id($lastProductId);
    return $result;
  }

  public function getOrdersBy_userId()
  {
    $query = "
SELECT
  $this->table.id AS id,
  $this->table.user_id,
  $this->table.total,
  $this->table.created_at,
  $this->table.modified_at,
  order_items.product_id,
  order_items.quantity,
  product.name,
  product.image_url,
  product.price
FROM $this->table
JOIN order_items ON $this->table.id = order_items.order_id
JOIN product ON order_items.product_id = product.id
WHERE user_id = :userId;
";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam('userId', $this->user_id);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    return $result;
  }
}
