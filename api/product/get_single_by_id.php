<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
include_once '../../config/Database.php';
include_once '../../models/Product.php';

$database = new Database();
$conn = $database->connect();

$product = new Product($conn);

try {
  if (!isset($_GET['productId'])) {
    throw new Exception("missing productId in query string");
  }
  $productId = $_GET['productId'];
  $product->id = $productId;
  $result = $product->searchBy_id($productId);

  if (!$result) {
    throw new Exception("Sorry, we could not find the product.");
  }

  http_response_code(200);
  echo json_encode(array(
    "success" => true,
    "product" => $result,
  ));
} catch (Exception $e) {
  http_response_code(400); // bad request
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage(),
  ));
}
