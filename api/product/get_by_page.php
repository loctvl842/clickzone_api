<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');

include_once '../../config/Database.php';
include_once '../../models/Product.php';

$database = new Database();
$conn = $database->connect();

$product = new Product($conn);

try {
  $page = $_GET['page'] ?? 0;
  $num = $_GET['num'] ?? 36;
  $products = $product->getByPage($page, $num);

  http_response_code(200); // bad request
  echo json_encode(array(
    "success" => true,
    "products" => $products,
  ));
} catch (Exception $e) {
  http_response_code(500);
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage(),
  ));
}
