<?php
// Header
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../../config/Database.php';
include_once '../../models/User.php';

$database = new Database();
$conn = $database->connect();

$user = new User($conn);

$user_input = json_decode(file_get_contents("php://input"));

$user->email = $user_input->email;
$user->password = $user_input->password;

if ($user->login()) {
  echo json_encode(
    array('message' => 'success')
  );
} else {
  echo json_encode(
    array('message' => 'fail')
  );
}
