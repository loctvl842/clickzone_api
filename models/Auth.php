<?php
require_once __DIR__ . '/../vendor/autoload.php';

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class Auth
{
  public static function generateAccessToken($payload)
  {
    $key = $_ENV['ACCESS_TOKEN_SECRET'];
    $issuedAt = new DateTimeImmutable();
    $expire = $issuedAt->modify('+15 seconds')->getTimestamp();
    $serverName = $_ENV["DB_HOST"];
    $data = [
      'iat' => $issuedAt->getTimestamp(),
      'iss' => $serverName,
      'nbf' => $issuedAt->getTimestamp(),
      'exp' => $expire,
      'userId' => $payload
    ];
    $token = JWT::encode($data, $key, 'HS256');
    return $token;
  }

  public static function generateRefreshToken($payload)
  {
    $key = $_ENV['REFRESH_TOKEN_SECRET'];
    $issuedAt = new DateTimeImmutable();
    $expire = $issuedAt->modify('+1 hour')->getTimestamp();
    $serverName = $_ENV["DB_HOST"];
    $data = [
      'iat' => $issuedAt->getTimestamp(),
      'iss' => $serverName,
      'nbf' => $issuedAt->getTimestamp(),
      'exp' => $expire,
      'userId' => $payload
    ];
    $token = JWT::encode($data, $key, 'HS256');
    return $token;
  }

  public static function verify($token, $key)
  {
    $decoded = JWT::decode($token, new Key($key, "HS256"));
    $userId = $decoded->userId;
    return $userId;
  }
}
