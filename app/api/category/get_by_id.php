<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
include_once '../../config/Database.php';
include_once '../../models/Category.php';

$database = new Database();
$conn = $database->connect();

$categoryController = new Category($conn);

try {
  if (!isset($_GET['category_id'])) {
    throw new Exception("missing categoryId in query string");
  }
  $categoryController->id = $_GET['category_id'];
  $category = $categoryController->getBy_id();

  http_response_code(200);
  echo json_encode(array(
    "success" => true,
    "category" => $category,
  ));
} catch (Exception $e) {
  http_response_code(500);
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage(),
  ));
}
