<?php
class Database
{
  // mysql://beb26cb7f801e0:ea61feec@us-cdbr-east-06.cleardb.net/heroku_b4ebe9b2bef200e?reconnect=true
  // deployed info
  // private $host = "us-cdbr-east-06.cleardb.net";
  // private $db_name = "heroku_b4ebe9b2bef200e";
  // private $username = "beb26cb7f801e0";
  // private $password = "ea61feec";

  // dev info
  private $host = "localhost";
  private $db_name = "click_zone";
  private $username = "mysql";
  private $password = "thangcho";

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
