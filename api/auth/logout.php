<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: DELETE');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');

include_once '../../config/Database.php';
include_once '../../models/User.php';

$database = new Database();
$conn = $database->connect();

$userController = new User($conn);

try {
  if (!isset($_GET['userId'])) {
    throw new Exception('Please provide userId in query string', 403);
  }
  $userController->id = $_GET['userId'];
  throw new Exception($_GET['userId'], 409);
  $userController->update_refreshToken(null);

  echo json_encode(array(
    "success" => true,
  ));
} catch (Exception $e) {
  http_response_code($e->getCode());
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage(),
  ));
}
