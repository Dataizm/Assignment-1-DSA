import ballerina/http;
import ballerina/io;

public function main() {
    http:Client helloClient = new("http://localhost:9090/hello");
    var response = helloClient->get("/sayHello");
    if (response is http:Response) {
        string payload = response.getTextPayload();
        io:println(payload);
    } else {
        io:println("Error: ", response.message());
    }
}
