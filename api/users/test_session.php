<?php
session_start();
echo json_encode($_SESSION);
// session_destroy();

// if (isset($_SESSION['loggedIn']) && $_SESSION['loggedIn'] && isset($_SESSION['user'])) {
//   echo json_encode(array(
//     "loggedIn" => true,
//     "message" => "data by session",
//     "user" => $_SESSION('user')
//   ));
//   return;
// } else {
//   echo isset($_SESSION['loggedIn']) ? "true" : "false";
// }
