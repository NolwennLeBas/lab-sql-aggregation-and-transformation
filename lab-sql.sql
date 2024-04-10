USE sakila;

-- Challenge 1
-- 1.1 shortest and longest movie durations:
SELECT * FROM  sakila.film;
SELECT min(length) AS min_duration FROM sakila.film;
SELECT max(length) AS max_duration FROM sakila.film;

-- 1.2 average movie duration in hours and minutes:
SELECT round(AVG (length)) AS average_duration FROM sakila.film;

-- 2.1 number of days that the company has been operating:
SELECT * FROM  sakila.rental;
SELECT datediff(max(rental_date), min(rental_date)) AS operating_days FROM sakila.rental;

-- 2.2 rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results:
SELECT * FROM sakila.rental;
SELECT *, month(rental_date) AS rental_month, 
dayofweek(rental_date) AS rental_weekday 
FROM sakila.rental
Limit 20;

-- 2.3 rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week:
SELECT *,
CASE
WHEN dayofweek(rental_date) = "0" OR dayofweek(rental_date) = "1" OR dayofweek(rental_date) = "2" OR dayofweek(rental_date) = "3" OR dayofweek(rental_date) = "4" then 'workday'
WHEN dayofweek(rental_date) = "5" OR dayofweek(rental_date) = "6" then 'weekend'
END AS 'DAY_TYPE'
FROM sakila.rental;

-- 3 retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.
SELECT * FROM sakila.film;
SELECT title,
ifnull(rental_duration, 'Not Available') AS availability
FROM sakila.film
ORDER BY title ASC;

-- 4 retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address:
SELECT * FROM sakila.customer;
SELECT *,
concat(first_name, " ", last_name, " ", left(email,3)) AS 'personalized_campaign' 
FROM sakila.customer
ORDER BY last_name ASC;

-- Challenge 2
-- 1.1 total number of films that have been released:
SELECT * FROM sakila.film;
SELECT count(*) FROM sakila.film;

-- 1.2 number of films for each rating:
SELECT * FROM sakila.film;
SELECT count(film_id), rating 
FROM sakila.film
GROUP BY rating;

-- 1.3 number of films for each rating, sorting the results in descending order:
SELECT count(film_id), rating 
FROM sakila.film
GROUP BY rating
ORDER BY count(film_id) DESC;

-- 2.1 mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places.
SELECT round(AVG(length),2) AS mean_duration, rating 
FROM sakila.film
GROUP BY rating
ORDER BY AVG(length) DESC;

-- 2.2 which ratings have a mean duration of over two hours in order to help select films:
SELECT round(AVG(length),2) AS mean_duration, rating
FROM sakila.film
GROUP BY rating
HAVING mean_duration>120;

-- 3 determine which last names are not repeated in the table actor:
SELECT * FROM sakila.actor;
SELECT count(actor_id) AS frequency, last_name
FROM sakila.actor
GROUP BY last_name
HAVING frequency=1;



