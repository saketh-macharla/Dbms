-- SQL assignment 2


--  1. Find out the number of documentaries with deleted scenes.

SELECT 
    COUNT(DISTINCT title)
FROM
    film
WHERE
    special_features LIKE '%Deleted Scenes%'
        AND film.film_id IN (SELECT 
            fc.film_id
        FROM
            category c,
            film_category fc
        WHERE
            c.name = 'Documentary'
                AND c.category_id = fc.category_id);

-- 2. Find out the number of sci-fi movies rented by the store managed by Jon Stephens.

  select  count(*) as ScifiCount
  from rental as r, inventory as i, film_list as fl, staff_list as sl
  where i.inventory_id = r.inventory_id 
		and r.staff_id = sl.ID
        and i.film_id = fl.FID
        and sl.name="Jon Stephens"
        and fl.category="sci-fi";
        
        
-- Alternative 
  SELECT 
    COUNT(*)
FROM
    category c,
    film_category fc,
    inventory i,
    rental r,
    staff s
WHERE
    c.name = 'Sci-fi'
        AND c.category_id = fc.category_id
        AND fc.film_id = i.film_id
        AND i.inventory_id = r.inventory_id
        AND r.staff_id = s.staff_id
        AND s.first_name = 'Jon'
        AND s.last_name = 'Stephens';
  
  
  
-- 3. Find out the total sales from Animation movies.

SELECT * FROM sakila.sales_by_film_category where category="Animation";


-- 4. Find out the top 3 rented category of movies by “PATRICIA JOHNSON”.

select category, count(*)
from 
film_list as fl, inventory as i , rental as r, customer_list as cl
where cl.name = "PATRICIA JOHNSON"
	  and fl.FID = i.film_id
      and i.inventory_id = r.inventory_id 
      and cl.ID=r.customer_id
group by category
order by count(*) DESC Limit 3;

-- Alternate  
select
    fl.category, COUNT(ALL fl.category)
FROM
    film_list fl
WHERE
    fl.FID IN (SELECT 
            i.film_id
        FROM
            customer_list cl,
            rental r,
            inventory i
        WHERE
            cl.name = 'PATRICIA JOHNSON'
                AND cl.ID = r.customer_id
                AND r.inventory_id = i.inventory_id
        GROUP BY i.film_id)
GROUP BY fl.category
ORDER BY COUNT(ALL fl.category) DESC , fl.category ASC
LIMIT 3;

--  5. Find out the number of R rated movies rented by “SUSAN WILSON”.

	select count(*) as filmCount
    from film_list as f, inventory as i, rental as r, customer_list as cl
    where f.FID=i.film_id
		and f.rating="R" 
        and i.inventory_id=r.inventory_id
        and cl.ID=r.customer_id
        and cl.name="SUSAN WILSON"; 
        
        
	