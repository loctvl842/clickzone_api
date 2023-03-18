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

  public function login()
  {
    // prepare
    $query = "SELECT id, username, email, password, phone FROM $this->table WHERE email = :email";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("email", $this->email);
    $stmt->execute();

    if ($stmt->rowCount() === 0) {
      return false;
    }
    else {
      $row = $stmt->fetch(PDO::FETCH_ASSOC);
      extract($row);
      if ($password !== $this->password) {
        return false;
      }
    }
    return true;
  }
}
