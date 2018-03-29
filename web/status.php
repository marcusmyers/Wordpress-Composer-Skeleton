<?php

$dbstatus = "";
$http_code = 200;
$arr_options = [];

if(getenv('MYSQL_SSL_CA')) {
  $arr_options = [ PDO::MYSQL_ATTR_SSL_CA => getenv('MYSQL_SSL_CA') ];
}

try {
  $database_handle = new PDO(
    "mysql:host=".getenv('MYSQL_HOST').";dbname=".getenv('MYSQL_DATABASE'),
    getenv('MYSQL_USERNAME'),
    getenv('MYSQL_PASSWORD'),
    $arr_options
  );
  $dbstatus = "connected";
} catch (PDOException $e) {
  $dbstatus = "disconnected";
  $http_code = 503;
}

header($_SERVER["SERVER_PROTOCOL"] . " " . $http_code, true, $http_code);
header('Content-type: application/json');
echo json_encode([
  "healthy" => ($http_code == 200 && $dbstatus == "connected" ? true : false),
  "message" => ($http_code == 200 && $dbstatus == "connected" ? "success" : "error")
]);
