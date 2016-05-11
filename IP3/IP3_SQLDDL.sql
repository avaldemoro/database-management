-- Create a new database called TheHipp
CREATE DATABASE TheHipp;

/* STEP 2
Create all the tables as follows:
	- write the CREATE statements for the table corresponding to each of
	  the relations. You must decide which data types (and field size, when
	  applicable) will be appropriate for each column in each table. Each 
	  table must have a Primary Key and the appropriate Foriegn keys (if
	  applicable) ~~
	- Write at least two ALTER statements to either add columns or Primary 
	  key or Foreign Key constraints to any of the tables~~
	- Execute all the CREATE and ALTER statements in MySQL
	- Use the DESC command to describe each table and include the results
	  as shown in the attached template

	  DESC Customer;
	  DESC Venue;
	  DESC Sponsor;
	  DESC Event;
	  DESC Movie;
	  DESC Play
	  DESC Play_Quote;
	  DESC Event_Show;
	  DESC Ticket;

	- LIst all the relationships in your database using the following
			SELECT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME, 
					REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
			FROM information_schema.KEY_COLUMN_USAGE
			WHERE (CONSTRAINT_SCHEMA = 'TheHipp');
*/

CREATE TABLE Customer (
	HippCode INT, 
	LastName VARCHAR(30) NOT NULL,
	FirstName VARCHAR(30) NOT NULL,
	Email VARCHAR(40), 
	Password VARCHAR(40),
	Street VARCHAR(30),
	City VARCHAR(30),
	Zip VARCHAR(5),
	Student BOOLEAN, 
	DonorID INT, 

	CONSTRAINT PK PRIMARY KEY(HippCode)
);

CREATE TABLE Venue (
	VenueID INT, 
	VenueName VARCHAR(30) NOT NULL,
	Capacity INT,
	SeatingChart BLOB, 
	TypesOfEvents VARCHAR(40),

	CONSTRAINT PK PRIMARY KEY(VenueID)
);

CREATE TABLE Event (
	EventCode INT, 
	EventName VARCHAR(30),
	Description VARCHAR(300),
	VenueID INT, -- FK: VenueID -> VENUE
	EventType VARCHAR(30),
	BaseTicketPrice DECIMAL(5,2),
	PromotionCost DECIMAL(5,2),
	ProductonCost DECIMAL(5,2),
	ScreeningCost DECIMAL(5,2),

	CONSTRAINT PK PRIMARY KEY(EventCode),
);

CREATE TABLE Sponsor (
	EventCode INT NOT NULL, -- FK: EventCode -> EVENT
	SponsorName VARCHAR(30), 
	Amount DECIMAL(6,2),
	
	CONSTRAINT PK PRIMARY KEY(EventCode, SponsorName),
	CONSTRAINT FK_EVENT FOREIGN KEY(EventCode) REFERENCES Event(EventCode)
);

CREATE TABLE Movie (
	EventCode INT, -- FK: EventCode -> EVENT
	Genre VARCHAR(30), 
	IMDB VARCHAR(100),

	CONSTRAINT PK PRIMARY KEY(EventCode),
	CONSTRAINT FK_EVENT FOREIGN KEY(EventCode) REFERENCES Event(EventCode)
);

CREATE TABLE Play (
	EventCode INT, 
	Director VARCHAR(30), 
	Author VARCHAR(30),
	Intermission VARCHAR(30),

	CONSTRAINT PK PRIMARY KEY(EventCode),
	CONSTRAINT FK_EVENT FOREIGN KEY(EventCode) REFERENCES Event(EventCode)
);

CREATE TABLE Play_Quote (
	EventCode INT, -- FK: EventCode -> EVENT
	QuoteID INT, 
	Quote VARCHAR(100),

	CONSTRAINT PK PRIMARY KEY(EventCode),
	CONSTRAINT FK_EVENT FOREIGN KEY(EventCode) REFERENCES Play(EventCode)
);

CREATE TABLE Event_Show(
	EventCode INT, -- FK: EventCode -> EVENT
	ShowDate DATE,
	ShowTime TIME,
	TicketPrice DECIMAL(5,2),

	CONSTRAINT PK PRIMARY KEY(EventCode, ShowDate, ShowTime),
	CONSTRAINT FK_EVENT FOREIGN KEY(EventCode) REFERENCES Event(EventCode)
);

CREATE TABLE Ticket (
	EventCode INT, -- FK: EventCode -> SHOW
	ShowDate DATE, -- FK: EventDate -> SHOW
	ShowTime TIME, -- FK: Time -> SHOW
	Seat VARCHAR(10),
	DateBought DATE,
	HippCode INT, --FK HippCode -> CUSTOMER
	Price DECIMAL (5,2),
	CouponCode VARCHAR(30),

	CONSTRAINT PK PRIMARY KEY(EventCode, ShowDate, ShowTime, Seat),
	CONSTRAINT FK_EVENT FOREIGN KEY(EventCode, ShowDate, ShowTime) REFERENCES Event_Show(EventCode, ShowDate, ShowTime),
	CONSTRAINT FK_HIPPCODE FOREIGN KEY(HippCode) REFERENCES Customer(HippCode)
);

ALTER TABLE Event -- First ALTER statement
ADD CONSTRAINT FK_VENUE FOREIGN KEY (VenueID) REFERENCES Venue(VenueID);

ALTER TABLE Play_Quote -- Second ALTER statement
ADD CONSTRAINT PK PRIMARY KEY(QuoteID);

INSERT INTO Customer
VALUES (1234, 'Smith', 'Jane', 'janesmith@gmail.com', 'password1', '123 UF St.', 'Gainesville', 32607, true, 1233);

INSERT INTO Venue 
VALUES (1, 'Downtown', 90, 0h6ABCDEF, Plays);

INSERT INTO Event
VALUES (123, 'Awareness Week', 'Literally just cry the entire week to raise awareness about tears', 1, 'The best type', 
	  	100.00, 110.00, 120.00, 130.00);

INSERT INTO Sponsor
VALUES (123, 'The Mighty Ducks', 1000.00);

INSERT INTO Movie
VALUES (123, 'Cry me a Genre-Genre', 'http://www.imdb.com/title/tt2652118/?ref_=nv_sr_1');

INSERT INTO Play
VALUES (123, 'Mr. Stink', 'Mrs. Stink', 'yeah');

INSERT INTO Play_Quote
VALUES (123, 1, 'What did the cat say to the dog? Nothing, cats dont speak');

INSERT INTO Event_Show
VALUES (123, 2016-04-16, 10:30:00, 120.00);

INSERT INTO Ticket
VALUES (123, 2016-04-16, 10:30:00, 'Row 20 Seat 3', 2016-04-01, 1234, 120.00, 'Please');

SELECT * FROM Customer;
SELECT * FROM Venue;	  
SELECT * FROM Event;
SELECT * FROM Sponsor;
SELECT * FROM Movie;
SELECT * FROM Play;
SELECT * FROM Play_Quote;	 
SELECT * FROM Event_Show;
SELECT * FROM Ticket;  	  	  	  
/* STEP 3
Insert data into the tables as follows:
	- Write one INSERT staement for each of the tables (you may use any
	  dummy data that you can make up)
	  
	  INSERT INTO TableName
	  VALUES (x, y, z);

	- Write a select statement for each of the table to display the 
	  contents of each table

	  SELECT *
	  FROM TableName

	- Execute all the INSERT and SELECT statements in MySQL
*/