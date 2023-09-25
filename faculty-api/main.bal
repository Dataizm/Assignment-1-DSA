//Client Implementation in Ballerina:

import ballerina/http;

public function main() {
    // Create HTTP client to interact with the API
    http:Client client = new("http://localhost:8080");

    // Define API requests and handle responses
    var response = client->get("/lecturers");
    if (response is http:Response) {
        match response {
            http:Response successResponse => {
                // Handle successful response with list of lecturers
            }
            _ => {
                // Handle other response statuses
            }
        }
    } else {
        // Handle HTTP client error
    }
    // Implement other API functionalities (POST, PUT, DELETE, etc.)
}// by Eric Lubinda J.L 222067438