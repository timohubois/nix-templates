<?php

echo "Hello from PHP!\n";
echo "PHP Version: " . phpversion() . "\n";
echo "Platform: " . php_uname('s') . " " . php_uname('m') . "\n";
echo "Extensions: " . implode(', ', array_slice(get_loaded_extensions(), 0, 5)) . "...\n";

// Example using built-in functionality
$data = [
    'message' => 'Hello from PHP!',
    'version' => phpversion(),
    'timestamp' => date('Y-m-d H:i:s'),
    'memory_usage' => memory_get_usage(true)
];

echo "\nJSON Output:\n";
echo json_encode($data, JSON_PRETTY_PRINT) . "\n";
