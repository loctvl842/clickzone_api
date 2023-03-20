<?php

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

  $user->username = $user_input->username;
  $user->email = $user_input->email;
  $user->password = $user_input->password;
  $user->add();
  echo json_encode(array(
    "registered" => true,
    "message" => "Register successfully",
  ));
} catch (Exception $e) {
  http_response_code(400);
  echo json_encode(array(
    "registered" => false,
    "message" => $e->getMessage(),
  ));
}
