<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
include_once '../../config/Database.php';
include_once '../../models/User.php';

$database = new Database();
$conn = $database->connect();

$userController = new User($conn);


try {
  $user_input = json_decode(file_get_contents("php://input"));

  $userController->username = $user_input->username;
  $userController->email = $user_input->email;
  $userController->password = $user_input->password;
  $userController->telephone = $user_input->telephone;

  if (empty($userController->username)) {
    throw new Exception("Username cannot be empty");
  }
  if (empty($userController->telephone)) {
    throw new Exception("Telephone cannot be empty");
  }
  if (empty($userController->email)) {
    throw new Exception("Email cannot be empty");
  }
  // Validate email
  if (!filter_var($userController->email, FILTER_VALIDATE_EMAIL)) {
    throw new Exception("Invalid email format");
  }
  if (empty($userController->password)) {
    throw new Exception("Password cannot be empty");
  }

  if ($userController->searchBy_email()) {
    $msg = "Sorry, this email address is already in use. Please choose a different email address.";
    throw new Exception($msg);
  }

  if (strlen($userController->password) < User::$min_pwd_length) {
    $min_length = User::$min_pwd_length;
    throw new Exception("Password must be at least $min_length characters long.");
  }

  $userController->add();
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
