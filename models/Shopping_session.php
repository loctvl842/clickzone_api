<?php
class Shopping_session
{
  private $conn;
  private $table = "shopping_session";

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
    $query = "SELECT * FROM $this->table WHERE id = :sessionId";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("sessionId", $this->id);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $result['total'] = floatval($result['total']);
    return $result;
  }

  public function searchBy_userId()
  {
    $query = "SELECT * FROM $this->table WHERE user_id = :user_id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("user_id", $this->user_id);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $result['total'] = floatval($result['total']);
    return $result;
  }

  public function add()
  {
    $query = "INSERT INTO $this->table(user_id)
              VALUES (:user_id)";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("user_id", $this->user_id);
    $stmt->execute();

    $lastProductId = $this->conn->lastInsertId();
    $this->id = $lastProductId;
    $result = $this->searchBy_id($lastProductId);
    return $result;
  }
}
