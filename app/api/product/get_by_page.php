<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');

include_once '../../config/Database.php';
include_once '../../models/Product.php';

$database = new Database();
$conn = $database->connect();

$productController = new Product($conn);

try {
  $sort = (int) ($_GET['sort'] ?? 0);
  $page = (int) ($_GET['page'] ?? 0);
  $num = (int) ($_GET['num'] ?? 36);
  $searchString = $_GET['search_string'] ?? null;
  $productController->category_id = (int) ($_GET['category_id'] ?? null);
  $products = $productController->getBy_pageNumber($sort, $page, $num, $searchString);
  http_response_code(200);
  echo json_encode(array(
    "success" => true,
    "products" => $products,
    "pageSize" => $num
  ));
} catch (Exception $e) {
  http_response_code(500);
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage(),
  ));
}
