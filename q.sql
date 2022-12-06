

SELECT f.title, c.name, COUNT(r.rental_id)
FROM film_category fc
         JOIN category c
              ON c.category_id = fc.category_id
         JOIN film f
              ON f.film_id = fc.film_id
         JOIN inventory i
              ON i.film_id = f.film_id
         JOIN rental r
              ON r.inventory_id = i.inventory_id
WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
GROUP BY 1, 2
ORDER BY 2, 1




SELECT f.title, c.name, f.rental_duration, NTILE(4) OVER (ORDER BY f.rental_duration) AS standard_quartile
FROM film_category fc
         JOIN category c
              ON c.category_id = fc.category_id
         JOIN film f
              ON f.film_id = fc.film_id
WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
ORDER BY 3





SELECT DATE_TRUNC('month', p.payment_date) pay_month, c.first_name || ' ' || c.last_name AS full_name, COUNT(p.amount) AS pay_countpermon, SUM(p.amount) AS pay_amount
FROM customer c
         JOIN payment p
              ON p.customer_id = c.customer_id
WHERE c.first_name || ' ' || c.last_name IN
      (SELECT t1.full_name
       FROM
           (SELECT c.first_name || ' ' || c.last_name AS full_name, SUM(p.amount) as amount_total
            FROM customer c
                     JOIN payment p
                          ON p.customer_id = c.customer_id
            GROUP BY 1
            ORDER BY 2 DESC
                LIMIT 10) t1) AND (p.payment_date BETWEEN '2007-01-01' AND '2008-01-01')
GROUP BY 2, 1
ORDER BY 2, 1,







SELECT t1.name, t1.standard_quartile, COUNT(t1.standard_quartile)
FROM
    (SELECT f.title, c.name , f.rental_duration, NTILE(4) OVER (ORDER BY f.rental_duration) AS standard_quartile
     FROM film_category fc
              JOIN category c
                   ON c.category_id = fc.category_id
              JOIN film f
                   ON f.film_id = fc.film_id
     WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')) t1
GROUP BY 1, 2
ORDER BY 1, 2
