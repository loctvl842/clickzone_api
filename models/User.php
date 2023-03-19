<?php
class User
{
  private $conn;
  private $table = "users";

  // user properties
  public $id;
  public $username;
  public $email;
  public $password;
  public $phone;

  // Constructor with DB
  public function __construct($conn)
  {
    $this->conn = $conn;
  }

  public function searchby_email()
  {
    // prepare
    $query = "SELECT id, username, email, password, phone FROM $this->table WHERE email = :email";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("email", $this->email);
    $stmt->execute();
    if ($stmt->rowCount() === 0) {
      return false;
    }
    return $stmt->fetch(PDO::FETCH_ASSOC);
  }
}
