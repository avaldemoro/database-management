-- 1A) Write query using a subquery


use thehipp;
show tables;
#SELECT * FROM t1 WHERE column1 = (SELECT column1 FROM t2);
SELECT lastname, firstname
FROM customer 
WHERE NOT EXISTS 
(SELECT hippCode 
FROM ticket
WHERE ticket.hippcode = customer.hippcode) ;
#1b join
select distinct 
lastname, firstname
from customer
left outer join ticket
on ticket.hippcode = customer.hippcode
where ticket.hippcode is null;
#2venue
SELECT venue.venuename, venue.capacity, 
	ticket.price * count(ticket.datebought) AS TR,
	COUNT(ticket.datebought) AS AmountSold
FROM event INNER JOIN ticket 
ON ticket.eventcode = event.eventcode 
INNER JOIN Venue ON venue.venueID = event.venueID
Where ticket.datebought is not null
GROUP BY venuename, capacity, baseticketprice;



#3
SELECT event.eventname, 
	ticket.price*COUNT(Ticket.datebought) AS 'Revenue', 
	event.promotioncost, event.screeningcost, 
	(ticket.price*COUNT(ticket.datebought) - promotioncost - screeningcost) AS 'Total Profit'
FROM Event  INNER JOIN Ticket ON event.eventcode = ticket.eventcode
WHERE event.eventtype = 'M'
GROUP BY event.eventname, ticket.price, event.promotioncost, event.screeningcost
ORDER BY (ticket.price*COUNT(ticket.datebought) - promotioncost - screeningcost) DESC
LIMIT 5;

SELECT Event.EventName, Ticket.Price * COUNT(Ticket.DateBought) AS Revenue,
	Event.PromotionCost, Event.ScreeningCost, 
	(Ticket.Price * COUNT(Ticket.DateBought) - PromotionCost - ScreeningCost) AS TotalProfit
FROM Event INNER JOIN Ticket ON Event.EventCode = Ticket.EventCode
WHERE Event.EventType = 'M'
GROUP BY Event.EventName, Ticket.Price, Event.PromotionCost, Event.ScreeningCost
ORDER BY (Ticket.Price * COUNT(Ticket.DateBought) - PromotionCost - ScreeningCost) DESC
LIMIT 5;

#4
SELECT EventName, Description, VenueID,
CASE
	WHEN event.eventtype = 'M' THEN movie.genre
	WHEN event.eventtype = 'P' THEN play.author
END AS 'GenreorAuthor'
FROM 
Event LEFT JOIN Movie 
	ON event.eventcode = movie.eventCode 
LEFT JOIN Play  
	ON event.eventcode = play.eventCode;

	# new number 4   


SELECT EventName, Description, VenueID, Genre AS 'Genre/Author'
FROM Event, Movie
WHERE Event.EventCode = Movie.EventCode
UNION ALL 
SELECT EventName, Description, VenueID, Author AS 'Genre/Author'
FROM Event, Play
WHERE Event.EventCode = Play.EventCode;

# number 5 view
create or replace view ticketdetails as
select t.eventcode,
t.showdate,
t.showtime,
t.seat,
t.datebought,
t.hippcode,
t.price,
t.couponcode,
e.eventname,
e.description,
e.venueid,
e.eventtype,
e.BaseTicketPrice,
e.PromotionCost,
e.ProductionCost,
e.ScreeningCost
from ticket t, event e
where t.eventcode=e.eventcode;
#5a
select eventcode, eventname, count(eventcode) as numberofshows, screeningcost, 
(count(eventcode) *screeningcost) as totalscreeningcost, promotioncost, productioncost, 
((count(eventcode) *screeningcost) + promotioncost + productioncost) as totalcost,
sum(baseticketprice) as expectedrevenue, sum(price) as actualrevenue, 
(sum(baseticketprice)-sum(price)) as totaldiscountsgiven,
((count(eventcode) *screeningcost) + promotioncost + productioncost)- sum(price) as profit
from ticketdetails
group by eventcode, eventname, screeningcost, promotioncost, productioncost;

SELECT EventCode, EventName, COUNT(EventCode) AS NumberOfShows, ScreeningCost, 
	(COUNT(EventCode) * ScreeningCost) AS TotalScreeningCost, 
	PromotionCost, ProductionCost,
	((COUNT(EventCode) * ScreeningCost) + PromotionCost + ProductionCost) AS TotalCost,
	SUM(BaseTicketPrice) AS ExpectedRevenue, SUM(Price) AS ActualRevenue,
	(SUM(BaseTicketPrice) - SUM(Price)) AS TotalDiscountsGiven,
	((Count(EventCode) * ScreeningCost) + PromotionCost + ProductionCost) - SUM(Price) AS Profit
FROM TicketDetails 
GROUP BY EventCode, EventName, ScreeningCost, PromotionCost, ProductionCost;

SELECT HippCode, LastName, FirstName, Email, 
	COUNT(ShowDate.EventShow) AS TheaterTickets,
	
WHERE Ticket.EventCode = Movie.EventCode
FROM Event, Ticket;

WHERE (SELECT EventCode FROM Play
	WHERE Play.EventCode = Cusotmer.HippCode)

SELECT HippCode, LastName, FirstName, Email
FROM Customer;

SELECT HippCode, LastName, FirstName, Email
	COUNT(Play.EventCode) AS TheaterTickets
	COUNT(Movie.EventCode) AS MovieTickets
FROM Customer, Event, Movie
WHERE Event.EventCode = Play.EventCode
UNION ALL
SELECT HippCode, LastName, FirstName, Email
	COUNT(Play.EventCode) AS TheaterTickets
	COUNT(Movie.EventCode) AS MovieTickets
FROM Customer, Event, Movie
WHERE Event.EventCode = Movie.EventCode

ON Play.EventCode = Movie.EventCode;

SELECT Customer.CustomerID, Orders.OrderDate
FROM Customer LEFT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID;

SELECT EventName, Description, VenueID, Genre AS 'Genre/Author'
FROM Event, Movie
WHERE Event.EventCode = Movie.EventCode
UNION ALL 
SELECT EventName, Description, VenueID, Author AS 'Genre/Author'
FROM Event, Play
WHERE Event.EventCode = Play.EventCode;