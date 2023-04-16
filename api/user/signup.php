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
  $user->telephone = $user_input->telephone;

  if (empty($user->username)) {
    throw new Exception("Username cannot be empty");
  }
  if (empty($user->telephone)) {
    throw new Exception("Telephone cannot be empty");
  }
  if (empty($user->email)) {
    throw new Exception("Email cannot be empty");
  }
  // Validate email
  if (!filter_var($user->email, FILTER_VALIDATE_EMAIL)) {
    throw new Exception("Invalid email format");
  }
  if (empty($user->password)) {
    throw new Exception("Password cannot be empty");
  }

  if ($user->searchBy_email()) {
    $msg = "Sorry, this email address is already in use. Please choose a different email address.";
    throw new Exception($msg);
  }

  if (strlen($user->password) < User::$min_pwd_length) {
    $min_length = User::$min_pwd_length;
    throw new Exception("Password must be at least $min_length characters long.");
  }

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
