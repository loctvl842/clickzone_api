<?php
class User
{
  private $conn;
  private $table = "user";

  // user properties
  public $id;
  public $username;
  public $telephone;
  public $email;
  public $password;
  static public $min_pwd_length = 8;

  // Constructor with DB
  public function __construct($conn)
  {
    $this->conn = $conn;
  }

  public function searchBy_id()
  {
    $query = "SELECT id, username, email, password, telephone, is_admin
              FROM $this->table WHERE $this->table.id = :userId";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("userId", $this->id);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    return $result;
  }

  public function searchBy_email()
  {
    // Validate email
    if (!filter_var($this->email, FILTER_VALIDATE_EMAIL)) {
      throw new Exception("Invalid email format");
    }

    // prepare
    $query = "SELECT id, username, email, password, telephone, is_admin
              FROM $this->table WHERE email = :email";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("email", $this->email);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    return $result;
  }

  public function add()
  {
    $query = "INSERT INTO $this->table(username, telephone, email, password)
              VALUES (:username, :telephone, :email, :password)";
    $stmt = $this->conn->prepare($query);
    $this->username = htmlspecialchars(strip_tags($this->username));
    $this->telephone = htmlspecialchars(strip_tags($this->telephone));
    $this->email = htmlspecialchars(strip_tags($this->email));
    $this->password = htmlspecialchars(strip_tags($this->password));

    // hash password
    $this->password = password_hash($this->password, PASSWORD_BCRYPT);

    $data = array(
      "username" => $this->username,
      "telephone" => $this->telephone,
      "email" => $this->email,
      "password" => $this->password
    );
    return $stmt->execute($data);
  }

  public function update_refreshToken($refreshToken)
  {
    $query = "UPDATE $this->table SET refresh_token = :refreshToken WHERE id = :userId";
    $stmt = $this->conn->prepare($query);
    if ($refreshToken === null) {
      throw new Exception('loc', 409);

      $stmt->bindParam('refreshToken', null, PDO::PARAM_NULL);
    } else $stmt->bindParam('refreshToken', $refreshToken);
    $stmt->bindParam('userId', $this->id);
    $stmt->execute();
  }

  public function searchBy_refreshToken($refreshToken)
  {
    $query = "SELECT id, username, email, password, telephone, is_admin
              FROM $this->table WHERE $this->table.refresh_token = :refreshToken";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam("refreshToken", $refreshToken);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    return $result;
  }
}
