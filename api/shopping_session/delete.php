<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: DELETE');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
include_once '../../config/Database.php';
include_once '../../models/Shopping_session.php';

$database = new Database();
$conn = $database->connect();

$shoppingSessionController = new Shopping_session($conn);

try {
  if (!isset($_GET['session_id'])) {
    throw new Exception("Please provide session_id in search query");
  }

  $shoppingSessionController->id = $_GET['session_id'];
  $shoppingSessionController->removeBy_id();

  http_response_code(200);
  echo json_encode(array(
    "success" => true,
    "shopping_session" => $result,
  ));
} catch (Exception $e) {
  http_response_code(500);
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage(),
  ));
}
