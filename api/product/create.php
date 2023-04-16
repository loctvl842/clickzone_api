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

  $product->name = $user_input->name;
  $product->image_url = $user_input->image_url;
  $product->price = $user_input->price;
  $product->old_price = $user_input->old_price;
  $product->description = $user_input->description;

  if (empty($product->name)) {
    throw new Exception("Name of product cannot be empty.");
  }
  if (empty($product->image_url)) {
    throw new Exception("Please provide an image of product.");
  }
  if (empty($product->price)) {
    throw new Exception("Please provide price of product.");
  }

  $newProduct = $product->add();

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
