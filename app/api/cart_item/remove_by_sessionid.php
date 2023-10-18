<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: DELETE');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
include_once '../../config/Database.php';
include_once '../../models/Cart_item.php';

$database = new Database();
$conn = $database->connect();

$cartItemController = new Cart_item($conn);

try {
  if (!isset($_GET['session_id'])) {
    throw new Exception("Please provide session_id in search query");
  }

  $cartItemController->session_id = $_GET['session_id'];
  $cartItemController->removeBy_sessionId();

  http_response_code(200);
  echo json_encode(array(
    "success" => true,
  ));
} catch (Exception $e) {
  http_response_code(500);
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage(),
  ));
}
