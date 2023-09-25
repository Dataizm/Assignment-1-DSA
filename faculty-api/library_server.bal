import ballerina/grpc;
import library;

type BooksDB record {
    map<string, Book> books = {};
};

service LibraryService on new grpc:Listener(9090) {
    BooksDB booksDB;

    // Implement server-side functions
    resource function addBook(Book book) returns (string) {
        // Implement logic to add a book and return its ISBN
        // Update booksDB
        return book.isbn;
    }

    resource function createUsers(stream User users) returns (string) {
        // Implement logic to create users and return a response
        return "Users created successfully";
    }

    resource function updateBook(Book book) returns (Book) {
        // Implement logic to update a book and return the updated book
        return book;
    }

    resource function removeBook(string isbn) returns (Book[]) {
        // Implement logic to remove a book and return the updated book list
        // Update booksDB
        delete booksDB.books[isbn];
        return booksDB.books.values().toArray();
    }

    resource function listAvailableBooks() returns stream<Book> {
        // Implement logic to list all available books
        foreach var book in booksDB.books.values() {
            if (book.available) {
                _ = check grpc:send(book);
            }
        }
    }

    resource function locateBook(string isbn) returns (string) {
        // Implement logic to locate a book by ISBN and return its location
        if (booksDB.books[isbn].available) {
            return booksDB.books[isbn].location;
        } else {
            return "Book not available";
        }
    }

    resource function borrowBook(User user) returns (string) {
        // Implement logic to handle book borrowing by a user
        // Update book availability and user records
        return "Book borrowed successfully";
    }
}

public function main() {
    // Start the gRPC server
    grpc:ListenerConfiguration listenerConfig = {
        port: 9090
    };
    grpc:startListener(listenerConfig, new grpc:ServiceConfig(), libraryService);
}
// by tangeni daniel 218017758 and Patrick Mufalo Mutabelezi 222127767
