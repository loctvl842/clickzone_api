<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');

include_once '../../config/Database.php';
include_once '../../models/Product.php';
include_once '../../models/Category.php';

$database = new Database();
$conn = $database->connect();

$categoryController = new Category($conn);
$productController = new Product($conn);

try {
  if (!isset($_GET['category_id'])) {
    throw new Exception("missing category_id in query string");
  }
  $categoryController->id = $_GET['category_id'];
  $categoryParentId = $categoryController->search_parentId();
  $productController->category_id = $categoryParentId;
  $products = $productController->getBy_pageNumber(0, 0, 8);

  http_response_code(200);
  echo json_encode(array(
    "success" => true,
    "products" => $products,
  ));
} catch (Exception $e) {
  http_response_code($e->getCode());
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage(),
  ));
}
