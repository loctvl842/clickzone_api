<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
include_once '../../config/Database.php';
include_once '../../models/User.php';
include_once '../../models/Auth.php';

$database = new Database();
$conn = $database->connect();

$userController = new User($conn);

function checkAuth($user, $user_input)
{
  if (!$user) {
    $msg = "The email address you entered is incorrect.";
    throw new Exception($msg, 401); // unauthorized
  }
  // check password match
  if (!password_verify($user_input->password, $user["password"])) {
    $msg = "Password is incorrect. Please try again.";
    throw new Exception($msg, 401); // unauthorized
  }
}

try {
  $user_input = json_decode(file_get_contents("php://input"));
  $userController->email = $user_input->email;
  $user = $userController->searchBy_email();
  checkAuth($user, $user_input);
    // login successfully
  ;
  $accessToken = Auth::generateAccessToken($user['id']);
  $refreshToken = Auth::generateRefreshToken($user['id']);
  $userController->id = $user['id'];
  $userController->update_refreshToken($refreshToken);

  echo json_encode(array(
    "success" => true,
    "tokens" => array(
      "accessToken" => $accessToken,
      "refreshToken" => $refreshToken
    ),
  ));
} catch (Exception $e) {
  $statusCode = $e->getCode();
  $message = $e->getMessage();
  http_response_code($statusCode);
  echo json_encode(array(
    "success" => false,
    "message" => $message
  ));
}
