<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token, Authorization');
include_once '../../config/Database.php';
include_once '../../models/User.php';

$database = new Database();
$conn = $database->connect();

$userController = new User($conn);

try {
  require_once "../../middleware/auth.php";
  $userController->id = $userId;
  $user = $userController->searchBy_id($userId);

  echo json_encode(array(
    "success" => true,
    "user" => $user
  ));
} catch (Exception $e) {
  $statusCode = $e->getCode();
  $message = $e->getMessage();
  http_response_code($statusCode);
  echo json_encode(array(
    "success" => false,
    "message" => $message,
  ));
}
