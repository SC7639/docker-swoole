<?php

require_once __DIR__ . '/vendor/autoload.php';

$http = new swoole_http_server('0.0.0.0', 9501);

$http->on('start', function ($server) {
    echo "Swoole http server is started at http://0.0.0.0:9501\n";
});

$i = 0;
$http->on('request', function ($request, $response) {
    go(function () use (&$i) {
        echo "Request $i";
        $i++;
    });

    go(function () use ($response) {
        $response->header("Content-Type:", "text/plain");
        $response->end("Hello world\n");
    });
});

$http->start();
