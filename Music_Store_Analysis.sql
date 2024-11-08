--Who is the senior most employee based on job title?

Select Top 1 * 
From employee
Order By levels desc 

--Which countries as most Invoices?

Select COUNT(*) c, billing_country 
From invoice
Group By billing_country
Order By c DESC

--What are top 3 values of total invoices

Select TOP 3 total  
From invoice
Order By total DESC

--Which city has the best customer? We would like to throw a promotional Music Festival in the city we made the most money.
--Write a query that returns one city that has the highest sum of invoice totals.
--Return both the city name and sum of all invoice totals.

Select SUM(total) invoice_total, billing_city 
From invoice
Group By billing_city 
Order By invoice_total DESC

--Who is the best customer? The customer who has spent the most money will be declared the best customer.
--Write a query that returns the person who has spent the most money.

Select TOP 1 customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) Total
From customer
JOIN invoice 
ON customer.customer_id = invoice.customer_id
Group By customer.customer_id, customer.first_name, customer.last_name
Order By Total DESC

--Write query to return the email, first name, last name & Genre of all Rock Music listeners. 
--Return your list ordered alphabetically by email starting with A

Select DISTINCT c.email, c.first_name, c.last_name
From customer c 
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line ON i.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id 
	FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
Order By c.email;

--Let's invite the artists who have written the most rock music in our dataset.
--Write query that returns the Artist name and total track count of the top 10 rock bands.

Select TOP 10 artist.artist_id, artist.name, COUNT(artist.artist_id) number_of_songs
From track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'ROCK'
Group by artist.artist_id, artist.name
Order by number_of_songs DESC

