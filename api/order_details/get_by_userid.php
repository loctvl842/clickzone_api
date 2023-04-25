<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
include_once '../../config/Database.php';
include_once '../../models/Order_details.php';

$database = new Database();
$conn = $database->connect();

$orderDetailsController = new Order_details($conn);

try {
  require_once "../../middleware/auth.php";
  $orderDetailsController->user_id = $userId;
  $orders = $orderDetailsController->getOrdersBy_userId();

  http_response_code(200);
  echo json_encode(array(
    "success" => true,
    "orders" => $orders,
  ));
} catch (Exception $e) {
  http_response_code($e->getCode());
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage(),
  ));
}
