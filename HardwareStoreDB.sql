CREATE DATABASE HardwareStoreDB
GO

USE HardwareStoreDB
GO


-- Client table
CREATE TABLE Client (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Address VARCHAR(250),
    City VARCHAR(50)
);

-- Supplier table
CREATE TABLE Supplier (
    Id INT PRIMARY KEY IDENTITY(1,1),
    SupplierName VARCHAR(100) NOT NULL,
	Phone VARCHAR(20) NOT NULL,
	Email VARCHAR(50),
    Address VARCHAR(250),
    City VARCHAR(50)
);

-- Category table
CREATE TABLE Category (
    Id INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(50) NOT NULL,
    Description VARCHAR(250)
);

--  Employee table
CREATE TABLE Employee (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
	Phone VARCHAR(20),
	Email VARCHAR(50),
	Salary DECIMAL(10,2),
    Address VARCHAR(255),
    City VARCHAR(50)
);

-- Product table
CREATE TABLE Product (
    Id INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT NOT NULL,
    SupplierID INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL CHECK(UnitPrice > 0),
    UnitsInStock INT NOT NULL CHECK(UnitsInStock >= 0),
    CONSTRAINT FK_Product_Category FOREIGN KEY (CategoryID) REFERENCES Category(Id),
    CONSTRAINT Fk_Product_Supplier FOREIGN KEY (SupplierID) REFERENCES Supplier(Id)
);


-- Sale table
CREATE TABLE Sale (
    Id INT PRIMARY KEY IDENTITY(1,1),
    ClientID INT NOT NULL,
    EmployeeID INT NOT NULL,
    SaleDate DATE DEFAULT GETDATE(),
    Total DECIMAL(10, 2),
    CONSTRAINT FK_Sale_Client FOREIGN KEY (ClientID) REFERENCES Client(Id),
    CONSTRAINT FK_Sale_Employee  FOREIGN KEY (EmployeeID) REFERENCES Employee(Id)
);

-- SaleDetails table
CREATE TABLE SaleDetails (
    Id INT PRIMARY KEY IDENTITY(1,1),
    SaleID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
	Total AS Quantity * UnitPrice,
    CONSTRAINT FK_SaleDetails_Sale FOREIGN KEY (SaleID) REFERENCES Sale(Id),
    CONSTRAINT FK_SaleDetails_Product FOREIGN KEY (ProductID) REFERENCES Product(Id)
);
GO


-- Administrator table (login)
CREATE TABLE Administrator (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
	UserName VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(250) NOT NULL,
    Phone VARCHAR(20)
);
GO


-- ============  STORED PROCEDURES ============== ---

-- ========= Client ==============

-- Stored Procedure to Insert a Client
CREATE OR ALTER PROCEDURE spClient_Insert
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Phone VARCHAR(20),
    @Address VARCHAR(255),
    @City VARCHAR(50)
AS
BEGIN
    INSERT INTO Client (FirstName, LastName, Email, Phone, Address, City)
    VALUES (@FirstName, @LastName, @Email, @Phone, @Address, @City);
END;
GO

-- Stored Procedure to Get All Clients
CREATE OR ALTER PROCEDURE spClient_GetAll
AS
BEGIN
    SELECT Id, FirstName, LastName, Email, Phone, Address, City FROM Client;
END;
GO

-- Stored Procedure to Get a Client by ID
CREATE OR ALTER PROCEDURE spClient_GetById
    @ClientID INT
AS
BEGIN
    SELECT Id, FirstName, LastName, Email, Phone, Address, City  FROM Client WHERE Id = @ClientID;
END;
GO

-- Stored Procedure to Delete a Client
CREATE OR ALTER PROCEDURE spClient_Delete
    @ClientID INT
AS
BEGIN
    DELETE FROM Client WHERE Id = @ClientID;
END;
GO

-- Stored Procedure to Update a Client
CREATE OR ALTER PROCEDURE spClient_Update
    @ClientID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Phone VARCHAR(20),
    @Address VARCHAR(255),
    @City VARCHAR(50)
AS
BEGIN
    UPDATE Client
    SET 
        FirstName = @FirstName,
        LastName = @LastName,
        Email = @Email,
        Phone = @Phone,
        Address = @Address,
        City = @City
    WHERE Id = @ClientID;
END;
GO

-- ========= Category ==========

-- Stored Procedure to Insert a Category
CREATE OR ALTER PROCEDURE spCategory_Insert
    @CategoryName VARCHAR(50),
    @Description VARCHAR(250)
AS
BEGIN
    INSERT INTO Category (CategoryName, Description)
    VALUES (@CategoryName, @Description);
END;
GO

-- Stored Procedure to Get All Categories
CREATE OR ALTER PROCEDURE spCategory_GetAll
AS
BEGIN
    SELECT Id, CategoryName, Description FROM Category;
END;
GO

-- Stored Procedure to Get a Category by ID
CREATE OR ALTER PROCEDURE spCategory_GetById
    @CategoryID INT
AS
BEGIN
    SELECT Id, CategoryName, Description FROM Category WHERE Id = @CategoryID;
END;
GO

-- Stored Procedure to Delete a Category
CREATE OR ALTER PROCEDURE spCategory_Delete
    @CategoryID INT
AS
BEGIN
    DELETE FROM Category WHERE Id = @CategoryID;
END;
GO

-- Stored Procedure to Update a Category
CREATE OR ALTER PROCEDURE spCategory_Update
    @CategoryID INT,
    @CategoryName VARCHAR(50),
    @Description VARCHAR(250)
AS
BEGIN
    UPDATE Category
    SET 
        CategoryName = @CategoryName,
        Description = @Description
    WHERE Id = @CategoryID;
END;
GO


-- ========== Employee ==========

-- Stored Procedure to Insert an Employee
CREATE OR ALTER PROCEDURE spEmployee_Insert
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Phone VARCHAR(20),
    @Email VARCHAR(50),
    @Salary DECIMAL(10,2),
    @Address VARCHAR(255),
    @City VARCHAR(50)
AS
BEGIN
    INSERT INTO Employee (FirstName, LastName, Phone, Email, Salary, Address, City)
    VALUES (@FirstName, @LastName, @Phone, @Email, @Salary, @Address, @City);
END;
GO

-- Stored Procedure to Get All Employees
CREATE OR ALTER PROCEDURE spEmployee_GetAll
AS
BEGIN
    SELECT Id, FirstName, LastName, Phone, Email, Salary, Address, City FROM Employee;
END;
GO

-- Stored Procedure to Get an Employee by ID
CREATE OR ALTER PROCEDURE spEmployee_GetById
    @EmployeeID INT
AS
BEGIN
    SELECT Id, FirstName, LastName, Phone, Email, Salary, Address, City FROM Employee WHERE Id = @EmployeeID;
END;
GO

-- Stored Procedure to Delete an Employee
CREATE OR ALTER PROCEDURE spEmployee_Delete
    @EmployeeID INT
AS
BEGIN
    DELETE FROM Employee WHERE Id = @EmployeeID;
END;
GO

-- Stored Procedure to Update an Employee
CREATE OR ALTER PROCEDURE spEmployee_Update
	@EmployeeId INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Phone VARCHAR(20),
    @Email VARCHAR(50),
    @Salary DECIMAL(10,2),
    @Address VARCHAR(255),
    @City VARCHAR(50)
AS
BEGIN
    UPDATE Employee
    SET 
        FirstName = @FirstName,
        LastName = @LastName,
		Phone = @Phone,
		Email = @Email,
		Salary = @Salary,
		Address = @Address,
		City = @City
	WHERE Id = @EmployeeId	
END
GO


-- ========= Supplier ==============

-- Stored Procedure to Insert a Supplier
CREATE OR ALTER PROCEDURE spSupplier_Insert
    @SupplierName VARCHAR(100),
    @Phone VARCHAR(20),
	@Email VARCHAR(50),
    @Address VARCHAR(250),
    @City VARCHAR(50)
AS
BEGIN
    INSERT INTO Supplier (SupplierName, Phone, Email,Address, City)
    VALUES (@SupplierName, @Phone, @Email, @Address, @City);
END;
GO

-- Stored Procedure to Get All Suppliers
CREATE OR ALTER PROCEDURE spSupplier_GetAll
AS
BEGIN
    SELECT Id, SupplierName, Phone, Email, Address, City FROM Supplier;
END;
GO

-- Stored Procedure to Get a Supplier by ID
CREATE OR ALTER PROCEDURE spSupplier_GetById
    @SupplierID INT
AS
BEGIN
    SELECT Id, SupplierName, Phone, Email, Address, City FROM Supplier WHERE Id = @SupplierID;
END;
GO

-- Stored Procedure to Delete a Supplier
CREATE OR ALTER PROCEDURE spSupplier_Delete
    @SupplierID INT
AS
BEGIN
    DELETE FROM Supplier WHERE Id = @SupplierID;
END;
GO

-- Stored Procedure to Update a Supplier
CREATE OR ALTER PROCEDURE spSupplier_Update
    @SupplierID INT,
    @SupplierName VARCHAR(100),
    @Phone VARCHAR(20),
	@Email VARCHAR(50),
    @Address VARCHAR(250),
    @City VARCHAR(50)
AS
BEGIN
    UPDATE Supplier
    SET 
        SupplierName = @SupplierName,
        Phone = @Phone,
		Email = @Email,
        Address = @Address,
        City = @City
    WHERE Id = @SupplierID;
END;
GO


-- ========  Product ===========

-- Stored Procedure to Insert a Product
CREATE OR ALTER PROCEDURE spProduct_Insert
    @ProductName VARCHAR(100),
    @CategoryID INT,
    @SupplierID INT,
    @UnitPrice DECIMAL(10, 2),
    @UnitsInStock INT
AS
BEGIN
    INSERT INTO Product (ProductName, CategoryID, SupplierID, UnitPrice, UnitsInStock)
    VALUES (@ProductName, @CategoryID, @SupplierID, @UnitPrice, @UnitsInStock);
END;
GO

-- Stored Procedure to Get All Products
CREATE OR ALTER PROCEDURE spProduct_GetAll
AS
BEGIN
    SELECT A.Id, ProductName, UnitPrice, UnitsInStock, CategoryID, SupplierID, CategoryName, SupplierName FROM Product AS A
	INNER JOIN Category AS B ON A.CategoryID = B.Id
	INNER JOIN Supplier AS C ON A.SupplierID = C.Id;
END;
GO

-- Stored Procedure to Get a Product by ID
CREATE OR ALTER PROCEDURE spProduct_GetById
    @ProductID INT
AS
BEGIN
    SELECT A.Id, ProductName, UnitPrice, UnitsInStock, CategoryID, SupplierID, CategoryName, SupplierName FROM Product AS A
	INNER JOIN Category AS B ON A.CategoryID = B.Id
	INNER JOIN Supplier AS C ON A.SupplierID = C.Id
	WHERE A.Id = @ProductID;
END;
GO

-- Stored Procedure to Delete a Product
CREATE OR ALTER PROCEDURE spProduct_Delete
    @ProductID INT
AS
BEGIN
    DELETE FROM Product WHERE Id = @ProductID;
END;
GO


-- stored procedure to get product data for sale
CREATE OR ALTER PROCEDURE spProduct_GetInfoForSaleById
    @ProductID INT
AS
BEGIN
    SELECT Id, UnitPrice, UnitsInStock FROM Product 
	WHERE Id = @ProductID;
END;
GO

-- Stored Procedure to Update a Product
CREATE OR ALTER PROCEDURE spProduct_Update
    @ProductID INT,
    @ProductName VARCHAR(100),
    @CategoryID INT,
    @SupplierID INT,
    @UnitPrice DECIMAL(10, 2),
    @UnitsInStock INT
AS
BEGIN
    UPDATE Product
    SET 
        ProductName = @ProductName,
        CategoryID = @CategoryID,
        SupplierID = @SupplierID,
        UnitPrice = @UnitPrice,
        UnitsInStock = @UnitsInStock
    WHERE Id = @ProductID;
END;
GO


-- ========== Sale ==============
-- Stored Procedure to Insert a Sale
CREATE OR ALTER PROCEDURE spSale_Insert
    @ClientID INT,
    @EmployeeID INT,
    @SaleID INT OUTPUT
AS
BEGIN
    INSERT INTO Sale (ClientID, EmployeeID)
    VALUES (@ClientID, @EmployeeID);

    SET @SaleID = SCOPE_IDENTITY();
END

-- Stored Procedure to Get All Sales
CREATE OR ALTER PROCEDURE spSale_GetAll
AS
BEGIN
    SELECT A.Id, ClientID, B.FirstName + ' ' + B.LastName AS ClientName, EmployeeID, C.FirstName + ' ' + C.LastName AS EmployeeName, SaleDate, Total 
	FROM Sale AS A
	INNER JOIN Client AS B ON A.ClientID = B.Id
	INNER JOIN Employee AS C ON A.EmployeeID = C.Id;
END;
GO

-- Stored Procedure to Get a Sale by ID
CREATE OR ALTER PROCEDURE spSale_GetById
    @SaleID INT
AS
BEGIN
    SELECT A.Id, ClientID, B.FirstName + ' ' + B.LastName AS ClientName, B.Address + ' ' + B.City AS ClientAddress,
    B.Email AS ClientEmail,
	EmployeeID, C.FirstName + ' ' + C.LastName AS EmployeeName, SaleDate, Total 
	FROM Sale AS A
	INNER JOIN Client AS B ON A.ClientID = B.Id
	INNER JOIN Employee AS C ON A.EmployeeID = C.Id
	WHERE A.Id = @SaleID;
END;
GO



-- ============ Sale Details ==============
-- Stored Procedure to Insert a Sale Detail
CREATE OR ALTER PROCEDURE spSalesDetail_Insert
    @SaleID INT,
    @ProductID INT,
    @Quantity INT
AS
BEGIN

	DECLARE @UnitPrice DECIMAL(10,2);

    -- Obtener el precio del producto de la tabla Producto
    SELECT @UnitPrice = UnitPrice
    FROM Product
    WHERE Id = @ProductId;

    INSERT INTO SaleDetails (SaleID, ProductID, Quantity, UnitPrice)
    VALUES (@SaleID, @ProductID, @Quantity, @UnitPrice);
END;
GO

-- Stored Procedure to Get All Sales Details
CREATE OR ALTER PROCEDURE spSalesDetail_GetAll
AS
BEGIN
    SELECT A.Id, saleID, ProductID,ProductName, Quantity, A.UnitPrice, Total FROM SaleDetails AS A
	INNER JOIN Product AS B ON A.ProductID = B.Id;
END;
GO

-- Stored Procedure to Get a Sale Detail by ID
CREATE OR ALTER PROCEDURE spSalesDetail_GetById
    @SaleID INT
AS
BEGIN
    SELECT A.Id, Quantity, A.UnitPrice, ProductName,A.Total AS DetailTotal
	FROM SaleDetails AS A
	INNER JOIN Product AS B ON A.ProductID = B.Id 
	INNER JOIN Sale AS C ON A.SaleID = C.Id
	WHERE A.SaleID = @SaleID
END;
GO

-- ============ Administrator ===============

-- Stored Procedure to Insert an Administrator
CREATE OR ALTER PROCEDURE spAdministrator_Insert
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @UserName VARCHAR(50),
    @Email VARCHAR(50),
    @Password VARCHAR(250),
    @Phone VARCHAR(20)
AS
BEGIN
    INSERT INTO Administrator (FirstName, LastName,UserName, Email, Password, Phone)
    VALUES (@FirstName, @LastName, @UserName, @Email, @Password, @Phone);
END;
GO

-- Stored Procedure to Get All Administrators
CREATE OR ALTER PROCEDURE spAdministrator_GetAll
AS
BEGIN
    SELECT Id,FirstName,LastName,UserName,Email,Password,Phone FROM Administrator;
END;
GO

-- Stored Procedure to Get an Administrator by ID
CREATE OR ALTER PROCEDURE spAdministrator_GetById
    @AdministratorID INT
AS
BEGIN
    SELECT Id,FirstName,LastName,UserName,Email,Password,Phone FROM Administrator WHERE Id = @AdministratorID;
END;
GO

-- Stored Procedure to Delete an Administrator
CREATE OR ALTER PROCEDURE spAdministrator_Delete
    @AdministratorID INT
AS
BEGIN
    DELETE FROM Administrator WHERE Id = @AdministratorID;
END;
GO

-- Stored Procedure to Update an Administrator
CREATE OR ALTER PROCEDURE spAdministrator_Update
    @AdministratorID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @UserName VARCHAR(50),
    @Email VARCHAR(50),
    @Password VARCHAR(250),
    @Phone VARCHAR(20)
AS
BEGIN
    UPDATE Administrator
    SET 
        FirstName = @FirstName,
        LastName = @LastName,
        UserName = @UserName,
        Email = @Email,
        Password = @Password,
        Phone = @Phone
    WHERE Id = @AdministratorID;
END;
GO

-- ========================== TRIGGERS ============================
-- trigger en la tabla SaleDetails
CREATE OR ALTER TRIGGER trg_UpdateStockOnSale
ON SaleDetails
AFTER INSERT
AS
BEGIN
    DECLARE @ProductID INT;
    DECLARE @Quantity INT;

    SELECT @ProductID = i.ProductID, @Quantity = i.Quantity
    FROM inserted i;

    -- Verificar si hay suficiente stock
    IF EXISTS (SELECT 1 FROM Product WHERE Id = @ProductID AND UnitsInStock >= @Quantity)
    BEGIN
        -- Actualizar el stock del producto
        UPDATE Product
        SET UnitsInStock = UnitsInStock - @Quantity
        WHERE Id = @ProductID;
    END
    ELSE
    BEGIN
        -- Si no mostrar error
        ROLLBACK;
        RAISERROR ('La cantidad solicitada excede el stock disponible.', 16, 1);
    END
END;
GO

-- trigger to update Sale Total
CREATE TRIGGER trg_UpdateSaleTotal
ON SaleDetails
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        UPDATE Sale
        SET Total = (
            SELECT SUM(Quantity * UnitPrice)
            FROM SaleDetails
            WHERE SaleID = inserted.SaleID
        )
        FROM Sale
        INNER JOIN inserted ON Sale.Id = inserted.SaleID;
    END
END;
GO



--- daots de prueba
EXEC spCategory_Insert 'Taladros','Taladroo zzzz'
EXEC spCategory_Insert 'Destornilladores', 'herramienta para quitar tornillos :)'

EXEC spSupplier_Insert 'La Fabrica','2290-8710','lafabri@gmail.com','la avenida 17','San Salvador'

EXEC spProduct_Insert 'Taladro Percutor',1,1,22.35,40
EXEC spProduct_Insert 'Taladro Recargable',1,1,28.55,40
EXEC spProduct_Insert 'Destornillador Phillip',2,1,2.22,40
EXEC spProduct_Insert 'Desctornillador Electrico',2,1,2.90,40

EXEC spEmployee_Insert 'Juan', 'Perez','7566-9898','juan@gmail.com',500,'la avenida amapola','Santiago de Maria'

EXEC spClient_Insert 'Juana', 'Delgado', 'juana@gmail.com','2202-1222','La Quinta esquina','San Miguel'
EXEC spClient_Insert 'Emilia', 'Chacon', 'chaco@gmail.com','2232-1222','La Quinta avenida','San Miguel'