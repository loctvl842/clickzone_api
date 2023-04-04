<?php
session_start();

include_once '../../config/Database.php';
include_once '../../models/User.php';


$token = $_COOKIE["token"];
echo json_encode($_SESSION[$token]);

// $database = new Database();
// $conn = $database->connect();
//
// $user = new User($conn);
//
// $user->email = "loclepnvx@gmail.com";
// $result = $user->searchby_email();

// echo json_encode($result);

// echo json_encode(array(
//   "email" => "loclepnvx@gmail.com"
// ));
//

// echo $_COOKIE['user'];
