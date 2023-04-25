<?php
class Order_items
{
  private $conn;
  private $table = "order_items";

  public $id;
  public $order_id;
  public $product_id;
  public $quantity;

  // Constructor with DB
  public function __construct($conn)
  {
    $this->conn = $conn;
  }

  public function searchBy_id()
  {
    $query = "
    SELECT
      $this->table.id,
      $this->table.quantity,
      $this->table.product_id,
      product.name,
      product.image_url,
      product.price
    FROM $this->table
      LEFT JOIN product
      ON $this->table.product_id = product.id
    WHERE $this->table.id = :orderItemsId";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("orderItemsId", $this->id);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    return $result;
  }

  public function add()
  {
    $query = "INSERT INTO $this->table(order_id, product_id, quantity)
              VALUES (:order_id, :product_id, :quantity)";
    $stmt = $this->conn->prepare($query);
    $data = array(
      "order_id" => $this->order_id,
      "product_id" => $this->product_id,
      "quantity" => $this->quantity,
    );
    $stmt->execute($data);

    $lastProductId = $this->conn->lastInsertId();
    $this->id = $lastProductId;
    $result = $this->searchBy_id($lastProductId);
    return $result;
  }

  public function addFrom_cart_item($sessionId)
  {
    $query = "
INSERT INTO $this->table(order_id, product_id, quantity)
SELECT :orderId as order_id, product_id, quantity FROM cart_item
WHERE session_id = :sessionId";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("orderId", $this->order_id);
    $stmt->bindParam("sessionId", $sessionId);
    $stmt->execute();

    $newOrderItems = $this->getBy_orderId();
    return $newOrderItems;
  }

  public function getBy_orderId()
  {
    $query = "
    SELECT
      $this->table.id,
      $this->table.quantity,
      $this->table.product_id,
      product.name,
      product.image_url,
      product.price
    FROM $this->table
      LEFT JOIN product
      ON $this->table.product_id = product.id
    WHERE order_id = :orderId;
    ";

    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("orderId", $this->order_id);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    return $result;
  }
}
