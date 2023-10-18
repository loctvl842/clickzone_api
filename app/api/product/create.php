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

  $productController->name = $user_input->name;
  $productController->image_url = $user_input->image_url;
  $productController->category_id = $user_input->category_id;
  $productController->price = $user_input->price;
  $productController->old_price = $user_input->old_price;
  $productController->description = $user_input->description;

  if (empty($productController->name)) {
    throw new Exception("Name of product cannot be empty.");
  }
  if (empty($productController->image_url)) {
    throw new Exception("Please provide an image of product.");
  }
  if (empty($productController->price)) {
    throw new Exception("Please provide price of product.");
  }

  $newProduct = $productController->add();

  http_response_code(200);
  echo json_encode(array(
    "success" => true,
    "product" => $newProduct,
    "message" => "New product created and added to your store!"
  ));
} catch (Exception $e) {
  http_response_code(400); // bad request
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage(),
  ));
}
