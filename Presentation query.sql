create database librarymanagementsystem;
use LibraryManagementSystem;
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(100)
);
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(255),
    CategoryID INT,
    Publisher VARCHAR(100),
    YearPublished INT,
    QuantityAvailable INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    JoinDate DATE
);
CREATE TABLE Librarians (
    LibrarianID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100)
);
CREATE TABLE Borrow (
    BorrowID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    LibrarianID INT,
    BorrowDate DATE,
    DueDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (LibrarianID) REFERENCES Librarians(LibrarianID)
);
CREATE TABLE Returns (
    ReturnID INT PRIMARY KEY,
    BorrowID INT,
    ReturnDate DATE,
    FineAmount DECIMAL(10,2),
    FOREIGN KEY (BorrowID) REFERENCES Borrow(BorrowID)
);
INSERT INTO Categories VALUES
(1, 'Fiction'), (2, 'Science'), (3, 'History');
INSERT INTO Books VALUES
(1, 'biology', 'hamna', 1, 'fjtyggd', 2009, 5),
(2, 'history', 'yousaf ', 2, 'dgtycvc', 2004, 3),
(3, 'chemistry', 'Yusra', 3, 'yfdytud', 2011, 4);
INSERT INTO Members VALUES
(1, 'sadia', 'sadia@gmail.com', '2025-01-15'),
(2, 'ali', 'ali@gmail.com', '2025-02-10');
INSERT INTO Librarians VALUES
(1, 'laiba ', 'laiba@library.com'),
(2, 'amna', 'amna@library.com');
INSERT INTO Borrow VALUES
(1, 1, 1, 1, '2025-08-01', '2025-08-10'),
(2, 2, 2, 2, '2025-08-05', '2025-08-15');
INSERT INTO Returns VALUES
(1, 1, '2025-08-09', 0.00),
(2, 2, '2025-08-20', 10.00); 
SELECT m.Name AS Member, b.Title AS Book, br.BorrowDate, br.DueDate
FROM Borrow br
JOIN Books b ON br.BookID = b.BookID
JOIN Members m ON br.MemberID = m.MemberID;
SELECT m.Name AS Member, b.Title, br.DueDate, r.ReturnDate, r.FineAmount
FROM Returns r
JOIN Borrow br ON r.BorrowID = br.BorrowID
JOIN Members m ON br.MemberID = m.MemberID
JOIN Books b ON br.BookID = b.BookID
WHERE r.ReturnDate > br.DueDate;
SELECT m.Name, COUNT(br.BorrowID) AS TotalBorrowed
FROM Members m
LEFT JOIN Borrow br ON m.MemberID = br.MemberID
GROUP BY m.Name;
SELECT SUM(FineAmount) AS TotalFineCollected
FROM Returns;
SELECT Title, QuantityAvailable
FROM Books
WHERE QuantityAvailable > 0;

