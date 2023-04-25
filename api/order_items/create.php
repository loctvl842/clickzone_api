<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
include_once '../../config/Database.php';
include_once '../../models/Order_items.php';

$database = new Database();
$conn = $database->connect();

$orderItemsController = new Order_items($conn);

try {
  $user_input = json_decode(file_get_contents("php://input"));
  $orderItemsController->order_id = $user_input->order_id;
  $sessionId = $user_input->session_id;
  $newOrderItems = $orderItemsController->addFrom_cart_item($sessionId);

  http_response_code(200);
  echo json_encode(array(
    "success" => true,
    "order_items" => $newOrderItems,
  ));
} catch (Exception $e) {
  http_response_code($e->getCode());
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage(),
  ));
}
