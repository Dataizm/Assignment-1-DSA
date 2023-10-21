import ballerina/http;
import ballerina/io;

public function main() {
    http:Client nameClient = check new("http://localhost:9000/names");
    var response = nameClient->get("/list");
    if (response is http:Response) {
        string payload = check response.getTextPayload();
        io:println("Names: ", payload);
    } else {
        io:println("Error: ", response.message());
    }
}
