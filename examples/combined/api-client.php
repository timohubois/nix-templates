<?php

echo "🐘 PHP API Client\n";
echo "================\n\n";

$baseUrl = 'http://localhost:3000';

// Function to make HTTP requests using built-in functionality
function makeRequest($url) {
    $context = stream_context_create([
        'http' => [
            'method' => 'GET',
            'timeout' => 5,
            'header' => 'Content-Type: application/json'
        ]
    ]);

    $response = @file_get_contents($url, false, $context);

    if ($response === false) {
        return null;
    }

    return json_decode($response, true);
}

try {
    // Check API status
    echo "Checking API status...\n";
    $status = makeRequest("$baseUrl/api/status");

    if ($status) {
        echo "✅ API Status: " . $status['status'] . "\n";
        echo "📅 Timestamp: " . $status['timestamp'] . "\n";
        echo "🔧 Node.js: " . $status['runtime']['node'] . "\n";
        echo "💻 Platform: " . $status['runtime']['platform'] . " (" . $status['runtime']['arch'] . ")\n\n";

        // Get users
        echo "Fetching users...\n";
        $result = makeRequest("$baseUrl/api/users");

        if ($result && isset($result['users'])) {
            foreach ($result['users'] as $user) {
                echo "👤 {$user['name']} ({$user['email']})\n";
            }
        }
    } else {
        throw new Exception("Could not connect to API");
    }

} catch (Exception $e) {
    echo "❌ Error: Could not connect to API server\n";
    echo "💡 Make sure to run 'npm start' first to start the Node.js server\n";
    echo "📝 Details: " . $e->getMessage() . "\n";
}
