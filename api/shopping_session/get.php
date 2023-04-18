<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
include_once '../../config/Database.php';
include_once '../../models/User.php';
include_once '../../models/Shopping_session.php';

$database = new Database();
$conn = $database->connect();

$shoppingSessionController = new Shopping_session($conn);
$userController = new User($conn);

try {
  if (!isset($_GET['user_id'])) {
    throw new Exception("Please provide user_id in search query");
  }

  $userController->id = $_GET['user_id'];
  $searched_user = $userController->searchBy_id();
  if (!$searched_user) {
    throw new Exception("There is no user with id: " . $userController->id);
  }

  $shoppingSessionController->user_id = $userController->id;

  // don't create new session if there is one exist
  $result = $shoppingSessionController->searchBy_userId();
  if (!$result) {
    $result = $shoppingSessionController->add();
  }

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
