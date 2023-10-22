import ballerina/http;

service /lecturers on new http:Listener(1337) {

    resource function post addLect() returns string {
        return "Hello, World!";
    }
    resource function get allLect() returns string {
        return "Hi!";
    }
    resource function put upLect() returns string {
        return "Hi!";
    }
    resource function get lectInfo() returns string {
        return "Hi!";
    }
    resource function delete sNum() returns string {
        return "Hi!";
    }
    resource function get cour() returns string {
        return "Hi!";
    }
    resource function get office() returns string {
        return "Hi!";
    }
}
