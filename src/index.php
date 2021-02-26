<?php
/**
 * File Demo of a Lambda
 */

// Main lambda function
function index($input)
{
    // Testing the request body array
    // as return
    return APIResponse(json_encode($input));
}

function APIResponse($body)
{
    $headers = [
        'Content-Type' => 'application/json',
        'Access-Control-Allow-Origin' => '*',
        'Access-Control-Allow-Headers' => 'Content-Type',
        'Access-Control-Allow-Methods' => 'OPTIONS,POST,GET'
    ];

    // Padrão de saída
    return json_encode([
        'statusCode' => 200,
        'headers' => $headers,
        'body' => $body
    ]);
}
