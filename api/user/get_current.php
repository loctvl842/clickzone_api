<?php
session_start();

if (isset($_COOKIE['token'])) {
  http_response_code(200);
  $token = $_COOKIE["token"];
  $user_info = $_SESSION[$token];
  unset($user_info["password"]);
  echo json_encode($user_info);
} else {
  http_response_code(200);
  echo json_encode(array("message" => "Not logged in"));
}
