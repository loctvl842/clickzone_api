<?php
class Cart_item
{
  private $conn;
  private $table = "cart_item";

  public $id;
  public $session_id;
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
    WHERE $this->table.id = :cartItemId";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("cartItemId", $this->id);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    return $result;
  }

  public function add()
  {
    $query = "INSERT INTO $this->table(session_id, product_id, quantity)
              VALUES (:session_id, :product_id, :quantity)";
    $stmt = $this->conn->prepare($query);
    $data = array(
      "session_id" => $this->session_id,
      "product_id" => $this->product_id,
      "quantity" => $this->quantity,
    );
    $stmt->execute($data);

    $lastProductId = $this->conn->lastInsertId();
    $this->id = $lastProductId;
    $result = $this->searchBy_id($lastProductId);
    return $result;
  }

  public function updateBy_id()
  {
    $query = "UPDATE $this->table SET quantity = :quantity WHERE id = :cartItemId";
    $stmt = $this->conn->prepare($query);
    $data = array(
      "cartItemId" => $this->id,
      "quantity" => $this->quantity
    );
    $stmt->execute($data);

    // Get the ID of the last inserted row
    $lastProductId = $this->id;

    $result = $this->searchBy_id($lastProductId);
    return $result;
  }

  public function getBy_sessionId()
  {
    // $query = "SELECT id, session_id, product_id, quantity FROM $this->table
    //           WHERE session_id = :sessionId";
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
    WHERE session_id = :sessionId;
    ";

    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("sessionId", $this->session_id);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    return $result;
  }

  public function removeBy_id()
  {
    $query = "DELETE FROM $this->table WHERE $this->table.id = :cartItemId";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam('cartItemId', $this->id);
    $stmt->execute();
  }

  public function removeBy_sessionId()
  {
    $query = "DELETE FROM $this->table WHERE $this->table.session_id = :sessionId";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam('sessionId', $this->session_id);
    $stmt->execute();
  }
}
