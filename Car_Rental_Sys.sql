

DROP TABLE IF EXISTS PaymentReceipts;
DROP TABLE IF EXISTS Invoices;
DROP TABLE IF EXISTS RentalCars;
DROP TABLE IF EXISTS Rentals;
DROP TABLE IF EXISTS Cars;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS CustomerRates;
DROP TABLE IF EXISTS CarClass;

CREATE TABLE CarClass (
    ClassID SMALLINT NOT NULL AUTO_INCREMENT,
    ClassName VARCHAR(6) NOT NULL,
    Description VARCHAR(25) NOT NULL,
    MonthlyRate DECIMAL(8,2) NOT NULL,
    CONSTRAINT PK_CarClass PRIMARY KEY (ClassID)
);

CREATE TABLE CustomerRates (
    CustomerRateID TINYINT NOT NULL AUTO_INCREMENT,
    RatingScore TINYINT,
    Discount DECIMAL(5,2),
    CONSTRAINT PK_CustomerRates PRIMARY KEY (CustomerRateID)
);

CREATE TABLE Cars (
    PlateNo VARCHAR(12) NOT NULL,
    Brand VARCHAR(20) NOT NULL,
    Model VARCHAR(25) NOT NULL,
    Year SMALLINT NOT NULL,
    Status VARCHAR(1) NOT NULL,
    CarClassID SMALLINT NOT NULL,
    CONSTRAINT PK_Cars PRIMARY KEY (PlateNo),
    CONSTRAINT FK_Cars_CarClass 
        FOREIGN KEY (CarClassID) 
        REFERENCES CarClass(ClassID)
);

CREATE TABLE Customers (
    CustomerID SMALLINT NOT NULL AUTO_INCREMENT,
    CorporateName VARCHAR(25) NOT NULL,
    Email VARCHAR(30),
    Phone VARCHAR(12),
    CustomerRate TINYINT,
    CONSTRAINT PK_Customers PRIMARY KEY (CustomerID),
    CONSTRAINT FK_Customers_CustomerRates
        FOREIGN KEY (CustomerRate)
        REFERENCES CustomerRates(CustomerRateID)
);

CREATE TABLE Rentals (
    RentID SMALLINT NOT NULL AUTO_INCREMENT,
    CustomerID SMALLINT NOT NULL,
    StartDate DATE NOT NULL,
    FinishDate DATE,
    Status VARCHAR(1) NOT NULL,
    CONSTRAINT PK_Rentals PRIMARY KEY (RentID),
    CONSTRAINT FK_Rentals_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

CREATE TABLE RentalCars (
    RentID SMALLINT NOT NULL AUTO_INCREMENT,
    PlateNo VARCHAR(12) NOT NULL,
    CONSTRAINT PK_RentalCars PRIMARY KEY (RentID, PlateNo),
    CONSTRAINT FK_RentalCars_Rentals
        FOREIGN KEY (RentID)
        REFERENCES Rentals(RentID),
    CONSTRAINT FK_RentalCars_Cars
        FOREIGN KEY (PlateNo)
        REFERENCES Cars(PlateNo)
);

CREATE TABLE Invoices (
    InvoiceID SMALLINT NOT NULL AUTO_INCREMENT,
    RentID SMALLINT NOT NULL,
    Amount DECIMAL(8,2) NOT NULL,
    CONSTRAINT PK_Invoices PRIMARY KEY (InvoiceID),
    CONSTRAINT FK_Invoices_Rentals
        FOREIGN KEY (RentID)
        REFERENCES Rentals(RentID)
);

CREATE TABLE PaymentReceipts (
    PaymentID SMALLINT NOT NULL AUTO_INCREMENT,
    InvoiceID SMALLINT NOT NULL,
    Amount DECIMAL(8,2) NOT NULL,
    PaymentDate DATE,
    CONSTRAINT PK_PaymentReceipts PRIMARY KEY (PaymentID),
    CONSTRAINT FK_PaymentReceipts_Invoices
        FOREIGN KEY (InvoiceID)
        REFERENCES Invoices(InvoiceID)
);









