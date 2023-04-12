<?php
class Database
{
  // mysql://b180c081dcb982:6fbb298e@us-cdbr-east-06.cleardb.net/heroku_a0e4ed6b731d7f0?reconnect=true
  // deployed info
  private $host = "54.179.5.227";
  private $db_name = "clickzone";
  private $username = "loc";
  private $password = "Thangcho1234$";

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
      $this->conn = new PDO(
        "mysql:host=$this->host;dbname=$this->db_name",
        $this->username,
        $this->password,
        array(
          PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
          PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"
        )
      );
      $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch (PDOException $err) {
      echo "Connection Error: " . $err->getMessage();
    }
    return $this->conn;
  }
}
