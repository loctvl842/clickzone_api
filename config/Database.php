<?php

require_once __DIR__ . '/../vendor/autoload.php';

use Dotenv\Dotenv as Dotenv;

class Database
{
  private $host;
  private $db_name;
  private $username;
  private $password;

  private $conn;

  public function __construct()
  {

    $dotenv = Dotenv::createImmutable(__DIR__ . "/../");
    $dotenv->load();

    $this->host = $_ENV['DB_HOST'];
    $this->db_name = $_ENV['DB_NAME'];
    $this->username = $_ENV['DB_USERNAME'];
    $this->password = $_ENV['DB_PASSWORD'];
  }

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
