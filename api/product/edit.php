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
  $user_input = json_decode(file_get_contents("php://input"));

  $product->id = $user_input->id;

  $targetProduct = $product->searchBy_id();

  $product->name = $user_input->name ?? $targetProduct["name"];
  $product->image_url = $user_input->image_url ?? $targetProduct["image_url"];
  $product->price = $user_input->price ?? $targetProduct["price"];
  $product->old_price = $user_input->old_price ?? $targetProduct["old_price"];
  $product->description = $user_input->description ?? $targetProduct["description"];

  if (empty($product->name)) {
    throw new Exception("Name of product cannot be empty.");
  }
  if (empty($product->image_url)) {
    throw new Exception("Please provide an image of product.");
  }
  if (empty($product->price)) {
    throw new Exception("Please provide price of product.");
  }

  $updatedProduct = $product->editBy_id();
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
