import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
public type nameEntry record {|
    string name;
|};

public final table<nameEntry> nameTable = table [
    {name: "Alice"},
    {name: "Bob"},
    {name: "Charlie"}
];

service /names on new http:Listener(9000) {
    resource function get list() returns nameEntry[] {
        return nameTable.toArray();
    }
}