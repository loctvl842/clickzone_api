<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
include_once '../../config/Database.php';
include_once '../../models/Cart_item.php';

$database = new Database();
$conn = $database->connect();

$cart_item = new Cart_item($conn);

try {
  $user_input = json_decode(file_get_contents("php://input"));
  $cart_item->id = $user_input->id;
  $cart_item->quantity = $user_input->quantity;
  $newCartItem = $cart_item->updateBy_id();

  http_response_code(200);
  echo json_encode(array(
    "success" => true,
    "cart_item" => $newCartItem,
  ));
} catch (Exception $e) {
  http_response_code(500);
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage(),
  ));
}
