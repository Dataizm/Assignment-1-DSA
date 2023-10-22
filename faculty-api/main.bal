import ballerina/http;

service /hello on new http:Listener(1337) {

    resource function get sayHello() returns string {
        return "Hello, World!";
    }
    resource function get hi() returns string {
        return "Hi!";
    }
}
