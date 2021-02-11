<?php

//hello function
function index($input)
{
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

    return json_encode([
        'statusCode' => 200,
        'headers' => $headers,
        'body' => $body
    ]);
}
