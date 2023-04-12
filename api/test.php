<?php
session_start();

$page = $_GET['page'] ?? 0;
$num = $_GET['num'] ?? 36;

echo json_encode($_SESSION);


// $str =  "<p>asdfasdfasdfasdfasdfas</p><p>asdf</p><p>asdfa</p><p>asdfasd</p>";
//
// // echo $str;
// echo htmlspecialchars(strip_tags($str));

// $database = new Database();
// $conn = $database->connect();
//
// $user = new User($conn);
//
// $user->email = "loclepnvx@gmail.com";
// $result = $user->searchBy_email();

// echo json_encode($result);

// echo json_encode(array(
//   "email" => "loclepnvx@gmail.com"
// ));
//

// echo $_COOKIE['user'];
