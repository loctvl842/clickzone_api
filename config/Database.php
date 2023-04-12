<?php
class Database
{
  // mysql://b180c081dcb982:6fbb298e@us-cdbr-east-06.cleardb.net/heroku_a0e4ed6b731d7f0?reconnect=true
  // deployed info
  private $host = "us-cdbr-east-06.cleardb.net";
  private $db_name = "heroku_a0e4ed6b731d7f0";
  private $username = "b180c081dcb982";
  private $password = "6fbb298e";

  // dev info
  // private $host = "localhost";
  // private $db_name = "click_zone";
  // private $username = "mysql";
  // private $password = "thangcho";

  private $conn;

  public function connect()
  {
    $this->conn = null;
    try {
      $this->conn = new PDO("mysql:host=$this->host;dbname=$this->db_name", $this->username, $this->password);
      $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch (PDOException $err) {
      echo "Connection Error: " . $err->getMessage();
    }
    return $this->conn;
  }
}
