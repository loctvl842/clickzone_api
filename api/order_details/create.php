<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
include_once '../../config/Database.php';
include_once '../../models/Order_details.php';

$database = new Database();
$conn = $database->connect();

$orderDetailsController = new Order_details($conn);

try {
  $user_input = json_decode(file_get_contents("php://input"));
  $orderDetailsController->user_id = $user_input->user_id;
  $orderDetailsController->total = $user_input->total;
  $newOrderDetails = $orderDetailsController->add();

  http_response_code(200);
  echo json_encode(array(
    "success" => true,
    "order_details" => $newOrderDetails,
  ));
} catch (Exception $e) {
  http_response_code(500);
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage(),
  ));
}
