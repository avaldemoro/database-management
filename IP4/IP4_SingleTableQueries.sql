/* 1. List the LastName, FirstName, Email and DonorID for all the customers
who are also donors. Sort the results by LastName  */

SELECT col1, col2, ... col-n -- This lists the columns (and expressions)
	                          -- to be retuned from the query
FROM table 1, table 2, ... table-n -- Lists the tables that are going to be queried
WHERE condition(s) -- Indicate the conditions under which a row will be included in
	               -- the result
GROUP BY col(s) -- specify if need be grouped in any way
HAVING conditions(s) -- indicate the conditions under which a category (group) will 
	   				 -- be included
	   				 -- Able to have a GROUP BY without a HAVING but cannot have a HAVING without a GROUP BY
ORDER BY col(s) -- sorts the result according to specified criteria
LIMIT number; -- Indicate how many rows will be displayed

SELECT LastName, FirstName, Email, DonorID
FROM customer
WHERE DonorID != 0
ORDER BY LastName;

SELECT COUNT(Student) AS NumberOfStudents
FROM Customer;

-- 3. List the EventCode and hte Year for all the shows that are scheduled
-- in the month of December. Your query should display each event code 
-- only once

SELECT DISTINCT(EventCode), Year(ShowDate)
FROM EventShow 
WHERE Month(ShowDate) = 12;

SELECT VenueID, COUNT(*) AS NumberOfEvents
FROM Event
GROUP BY VenueID;


-- Sect B #5
SELECT EventCode, ShowDate, ShowTime, COUNT(DateBought) AS NumberOfTicketsSold
FROM Ticket
where month(datebought) = 11 AND year(datebought) = 2015
group by showdate desc
having numberofticketssold > 10 OR numberofticketssold= 10;

select hippcode, datebought as dateofpurchase, count(datebought) as numberoftickets
from ticket
group by hippcode
having max(numberoftickets)
limit 1;

SELECT HippCode, DateBought AS DateOfPurchase, COUNT(EventCode) AS NumberOfTicketsSold
FROM Ticket
GROUP BY HippCode
HAVING MAX(NumberOfTickets)
LIMIT 1;

******      select sponsorname, count(eventcode) as numberofevents, sum(amount) as amountdonated
from sponsor
group by sponsorname 
order by amountdonated;

SELECT DISTINCT SponsorName, COUNT(EventCode) AS NumberOfEvents, SUM(Amount) as amountdonated
FROM Sponsor
GROUP BY SponsorName
ORDER BY AmountDonated;

--9
select EventCode, count(datebought) as numberofticketssold, min(showdate) as firstshow, max(showdate) as lastshow
from ticket
group by EventCode
order by count(datebought) * price desc
Limit 5;


SELECT EventCode, Count(DateBought) AS NumberOfTicketsSold, MIN(ShowDate) AS DateOfFirstShow, MAX(ShowDate) AS DateOfLastShow
FROM Ticket
GROUP BY EventCode;
ORDER BY COUNT(DateBought) * Price DESC 
LIMIT 5;


