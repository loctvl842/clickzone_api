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

  // Constructor with DB
  public function __construct($conn)
  {
    $this->conn = $conn;
  }

  public function searchby_email()
  {
    // Validate email
    if (!filter_var($this->email, FILTER_VALIDATE_EMAIL)) {
      throw new Exception("Invalid email format");
    }

    // prepare
    $query = "SELECT id, username, email, password FROM $this->table WHERE email = :email";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("email", $this->email);
    $stmt->execute();
    if ($stmt->rowCount() === 0) {
      throw new Exception("Email doesn't exist!");
    }
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    return $result;
  }

  public function add()
  {
    if (empty($this->username)) {
      throw new Exception("Username cannot be empty");
    }
    if (empty($this->email)) {
      throw new Exception("Email cannot be empty");
    }
    // Validate email
    if (!filter_var($this->email, FILTER_VALIDATE_EMAIL)) {
      throw new Exception("Invalid email format");
    }
    if (empty($this->password)) {
      throw new Exception("Password cannot be empty");
    }

    $min_pwd_length = 8;
    if (strlen($this->password) < $min_pwd_length) {
      throw new Exception("Password must be at least $min_pwd_length characters long.");
    }
    $query = "INSERT INTO $this->table(username, email, password)
              VALUES (:username, :email, :password)";
    $stmt = $this->conn->prepare($query);
    $this->username = htmlspecialchars(strip_tags($this->username));
    $this->email = htmlspecialchars(strip_tags($this->email));
    $this->password = htmlspecialchars(strip_tags($this->password));

    // hash password
    $this->password = password_hash($this->password, PASSWORD_BCRYPT);

    $data = array(
      "username" => $this->username,
      "email" => $this->email,
      "password" => $this->password
    );
    return $stmt->execute($data);
  }
}
