<?php
// server.php
$home = '/home/ubuntu'
$host = '127.0.0.1';
$basePort = 8050;

$applications = [
    'auth-user-management' => [
        'path' => "$home/fms-auth-user-management/public",
        'port' => $basePort + 1,
    ],
    'notification-service' => [
        'path' => "$home/fms-notification-service/public",
        'port' => $basePort + 2,
    ],
    'vehicle-service' => [
        'path' => "$home/fms-vehicle-service/public",
        'port' => $basePort + 2,
    ],
    // Add more applications as needed
];

echo "PHP Server started\n";

foreach ($applications as $appName => $appInfo) {
    $appPath = $appInfo['path'];
    $port = $appInfo['port'];

    $command = "php -S $host:$port -t $appPath";
    exec($command, $output, $returnCode);
    if ($returnCode !== 0) {
        echo "Failed to start $appName\n";
    } else {
        echo "$appName started at http://$host:$port\n";
    }
}


