<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
include_once '../../config/Database.php';
include_once '../../models/User.php';
include_once '../../models/Auth.php';

use Firebase\JWT\ExpiredException;

$database = new Database();
$conn = $database->connect();

$userController = new User($conn);

try {
  $user_input = json_decode(file_get_contents("php://input"));
  if (!property_exists($user_input, 'refreshToken')) {
    throw new Exception("Missing refresh token", 403);
  }
  $refreshToken = $user_input->refreshToken;
  $userId = Auth::verify($refreshToken, $_ENV['REFRESH_TOKEN_SECRET']);

  $accessToken = Auth::generateAccessToken($userId);

  echo json_encode(array(
    "success" => true,
    "accessToken" => $accessToken,
  ));
} catch (ExpiredException $e) {
  // Token has expired.
  $response = new stdClass();
  $response->error = 'Token has expired.';
  http_response_code(401);
  header('Content-Type: application/json');
  echo json_encode($response);
  exit;
} catch (Exception $e) {
  http_response_code($e->getCode());
  echo json_encode(array(
    "success" => false,
    "message" => $e->getMessage()
  ));
}
