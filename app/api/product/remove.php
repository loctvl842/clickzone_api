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
  $user_input = json_decode(file_get_contents("php://input"));

  $productController->id = $user_input->productId;
  $productController->removeBy_id();
  echo json_encode(array(
    "success" => true,
    "message" => "remove successfully",
  ));
} catch (Exception $e) {
  http_response_code(500);
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage(),
  ));
}
