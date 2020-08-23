CREATE DATABASE lad 8
GO

USE lad 8
GO
CREATE TABLE Customer
(
	CustomerID INT PRIMARY KEY,
	CustomerName NVARCHAR(50),
	Address NVARCHAR(100),
	Phone CHAR(10)
)
GO

CREATE TABLE Books
(
	BookCode INT PRIMARY KEY,
	Category VARCHAR(10),
	Author VARCHAR(100),
	Publisher VARCHAR(50),
	Title VARCHAR(100),
	Price INT,
	ImStore INT
)
GO

CREATE TABLE BookSold
(
	BookSoldId INT PRIMARY KEY NOT NULL,
	CustomerID INT,
	BookCode INT,
	Date DATETIME,
	Price INT,
	Amount INT,
	CONSTRAINT Cus_sold FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	CONSTRAINT books_booksold FOREIGN KEY (BookCode) REFERENCES Books(BookCode)
)
GO

INSERT INTO Customer VALUES (1,N'MiNh',N' Hà Nội','123')
INSERT INTO Customer VALUES (2,N'Vương ',N' Hà Nội','456')
INSERT INTO Customer VALUES (3,N'Thắng',N' Hà Nội','789')
INSERT INTO Customer VALUES (4,N'Linh',N' Hà Nội','321')
INSERT INTO Customer VALUES (5,N'Nhật',N'T Hà Nội','654')
GO


INSERT INTO Books VALUES (12,'Thieu nhi','3F','NXB Kim Dong','doremon',50000,45)
INSERT INTO Books VALUES (23,'Thieu nhi','japan','NXB Kim Dong','conan',20000,86)
INSERT INTO Books VALUES (56,'Van Hoc','Nguyen Du','NXB tre','thuy kieu',50000,10)
INSERT INTO Books VALUES (67,'Van Hoc','ko bite','NXB Tuoi Tre','vck',1000,20)
INSERT INTO Books VALUES (78,'Van Hoc','ko biet','NXB Kim Dong','ohyeah',20000,15)
GO

INSERT INTO BookSold VALUES (12,1,817,'2009-07-12',3000,1)
INSERT INTO BookSold VALUES (23,2,812,'2020-11-22',5000,3)
INSERT INTO BookSold VALUES (56,3,843,'2019-02-11',100,2)
INSERT INTO BookSold VALUES (78,5,817,'2020-05-02',6000,3)
INSERT INTO BookSold VALUES (78,5,876,'2010-03-07',4000,5)
INSERT INTO BookSold VALUES (56,3,887,'2020-01-10',2000,1)
INSERT INTO BookSold VALUES (67,4,843,'2018-05-08',3000,5)
INSERT INTO BookSold VALUES (67,4,887,'2018-02-09',5000,2)
INSERT INTO BookSold VALUES (78,5,876,'2020-10-02',800,1)
GO


--Tạo một khung nhìn chứa danh sách các cuốn sách (BookCode, Title, Price) kèm theo số lượng đã bán được của mỗi cuốn sách.
CREATE VIEW Book_Sold AS SELECT BookSold.BookCode,Books.Title,BookSold.Price,BookSold.Amount FROM BookSold 
INNER JOIN Books ON Books.BookCode = BookSold.BookCode
SELECT * FROM BooK_Sold

--Tạo một khung nhìn chứa danh sách các khách hàng (CustomerID, CustomerName, Address) kèm theo số lượng các cuốn sách mà khách hàng đó đã mua.
CREATE VIEW Customer_By_Book AS
SELECT Customer.CustomerID,Customer.CustomerName,Customer.Address,BookSold.Amount FROM Customer 
INNER JOIN BookSold ON BookSold.CustomerID = Customer.CustomerID
SELECT * FROM Customer_By_Book

--Tạo một khung nhìn chứa danh sách các khách hàng (CustomerID, CustomerName, Address) đã mua sách kèm theo tên các cuốn sách mà khách hàng đã mua.
CREATE VIEW Customer_Buy_Book_Name AS
SELECT Customer.CustomerID,Customer.CustomerName,Customer.Address,Books.Title FROM Customer
INNER JOIN BookSold ON Customer.CustomerID = BookSold.CustomerID
INNER JOIN Books ON BookSold.BookCode = Books.BookCode
GO
SELECT * FROM Customer_Buy_Book_Name
CREATE VIEW TotalPrice AS
SELECT BookSold.Price,Customer.CustomerName,BoookSold.CustomerID FROM BookSold
INNER JOIN Customer ON BookSold.CustomerID = Customer.CustomerID
