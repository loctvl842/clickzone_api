<?php

require_once __DIR__ . '/../vendor/autoload.php';
include_once __DIR__ . "/../models/Auth.php";

try {
  $headers = apache_request_headers();
  if (!preg_match('/Bearer\s(\S+)/', $_SERVER['HTTP_AUTHORIZATION'], $matches)) {
    throw new Exception('Token not found in request', 400);
    exit;
  }

  $accessToken = $matches[1];
  if (!$accessToken) {
    header('HTTP/1.0 400 Bad Request');
    exit;
  }

  $userId = Auth::verify($accessToken, $_ENV['ACCESS_TOKEN_SECRET']);
} catch (Exception $e) {
  $statusCode = $e->getCode();
  $message = $e->getMessage();
  throw new Exception($message, $statusCode);
}
