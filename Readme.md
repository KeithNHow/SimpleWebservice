# Summary
This extension consists of a single codeunit.

# Simple Webservice
This codeunit contains a single function that calls an external webservice to get the public IP address of the machine running the codeunit. The function uses HttpClient to send a GET request to the api ipify, which returns the public IP address in JSON format. The function then parses the JSON response to extract and return the IP address as text.