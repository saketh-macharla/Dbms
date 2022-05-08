-- SQL assignment 1 


1 Find out the PG-13 rated comedy movies. DO NOT use the film_list table

	select f.film_id, f.title 
    from film as f, film_category as fc where f.film_id=fc.film_id and f.rating="PG-13" and fc.category_id=5;
    

-- 2  Find out the top 3 rented horror movies. 
SELECT 
    fl.title, COUNT(ALL fl.title)
FROM
    sakila.film_list fl,
    inventory i,
    rental r
WHERE
    fl.category = 'Horror'
        AND fl.FID = i.film_id
        AND i.inventory_id = r.inventory_id
GROUP BY title
ORDER BY COUNT(ALL fl.title) DESC
LIMIT 3;


-- 3. Find out the list of customers from India who have rented sports movies.
SELECT 
    name
FROM
    sakila.customer_list
WHERE
    country = 'India'
        AND ID IN (SELECT 
            r.customer_id
        FROM
            sakila.film_list fl,
            inventory i,
            rental r
        WHERE
            fl.category = 'Sports'
                AND fl.FID = i.film_id
                AND r.inventory_id = i.inventory_id
        GROUP BY r.customer_id);
        
-- 4. Find out the list of customers from Canada who have rented “NICK WAHLBERG” movies.

select c.name from
sakila.customer_list as c
where
	 c.country="Canada" 
	 and ID in (
	 select r.customer_id from
		actor a,
        film_actor fa,
        inventory i,
        rental r
        where
			a.first_name="NICK"
            and
            a.last_name="WAHLBERG"
            and
            a.actor_id=fa.actor_id
            and
            fa.film_id=i.film_id
            and
            i.inventory_id=r.inventory_id
            );
            
-- 5. Find out the number of movies in which “SEAN WILLIAMS” acted.

select count( DISTINCT fa.film_id) from actor a, film_actor fa where a.actor_id= fa.actor_id and a.first_name="SEAN" and a.last_name="WILLIAMS";

