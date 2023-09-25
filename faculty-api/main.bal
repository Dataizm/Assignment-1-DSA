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
                // You can process the response here
            }
            _ => {
                // Handle other response statuses (e.g., non-successful responses)
                // You can handle different HTTP status codes here
            }
        }
    } else {
        // Handle HTTP client error
        // You can handle errors related to making the HTTP request here
    }
    // Implement other API functionalities (POST, PUT, DELETE, etc.)
    // You can add more HTTP requests and processing logic here
}

}// by Eric Lubinda J.L 222067438
