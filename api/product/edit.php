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

  $productController->id = $user_input->id;

  $targetProduct = $productController->searchBy_id();

  $productController->name = $user_input->name ?? $targetProduct["name"];
  $productController->image_url = $user_input->image_url ?? $targetProduct["image_url"];
  $productController->price = $user_input->price ?? $targetProduct["price"];
  $productController->old_price = $user_input->old_price ?? $targetProduct["old_price"];
  $productController->description = $user_input->description ?? $targetProduct["description"];

  if (empty($productController->name)) {
    throw new Exception("Name of product cannot be empty.");
  }
  if (empty($productController->image_url)) {
    throw new Exception("Please provide an image of product.");
  }
  if (empty($productController->price)) {
    throw new Exception("Please provide price of product.");
  }

  $updatedProduct = $productController->editBy_id();
  http_response_code(200);
  echo json_encode(array(
    "success" => true,
    "message" => "Updated product successfully.",
    "product" => $updatedProduct
  ));
} catch (Exception $e) {
  http_response_code(400);
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage(),
  ));
}
