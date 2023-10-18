<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
include_once '../../config/Database.php';
include_once '../../models/Product.php';

$database = new Database();
$conn = $database->connect();

$productController = new Product($conn);

try {
  $productController->category_id = (int) ($_GET['category_id'] ?? null);
  $searchString = $_GET['search_string'] ?? null;
  $result = $productController->count($searchString);
  echo json_encode($result['product_count']);
} catch (Exception $e) {
  http_response_code(500);
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage(),
  ));
}
