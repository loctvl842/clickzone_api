<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
include_once '../../config/Database.php';
include_once '../../models/User.php';
include_once '../../models/Shopping_session.php';

$database = new Database();
$conn = $database->connect();

$shopping_session = new Shopping_session($conn);
$user = new User($conn);

try {
  if (!isset($_GET['user_id'])) {
    throw new Exception("Please provide user_id in search query");
  }

  $user->id = $_GET['user_id'];
  $searched_user = $user->searchBy_id();
  if (!$searched_user) {
    throw new Exception("There is no user with id: " . $user->id);
  }

  $shopping_session->user_id = $user->id;

  // don't create new session if there is one exist
  $result = $shopping_session->searchBy_userId();
  if (!$result) {
    $result = $shopping_session->add();
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
