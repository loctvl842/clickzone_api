<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');

session_start();

// unset all session variables
$_SESSION = array();

session_destroy();

http_response_code(200);
exit();
