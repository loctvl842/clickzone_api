<?php
session_start();

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
include_once '../../config/Database.php';
include_once '../../models/User.php';

$database = new Database();
$conn = $database->connect();

$user = new User($conn);


try {
  $user_input = json_decode(file_get_contents("php://input"));
  $user->email = $user_input->email;
  $user->password = $user_input->password;
  $result = $user->searchby_email();

  if (!password_verify($user->password, $result["password"])) {
    throw new Exception("Wrong password");
  }

  $_SESSION["loggedIn"] = true;
  $_SESSION["user"] = $result;

  echo json_encode(array(
    "loggedIn" => true,
    "message" => "Login successfully"
  ));
} catch (Exception $e) {
  http_response_code(401);
  echo json_encode(array(
    "loggedIn" => false,
    "message" => $e->getMessage()
  ));
}
