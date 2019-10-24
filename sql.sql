-- HINT: For all of these exercises, you'll need to google
-- *postgres's* standard deviation function.
-- There's 3, 1 of them doesn't work, and one of them is more
-- appropriate. Try to pick the best one.


-- 1) Get the average and standard deviation of purchase amounts 
-- in our database.
-- Write down these numbers.

SELECT ROUND(AVG(amount), 2) as avg_amount, ROUND(STDDEV(amount), 2) as stdev_amount
FROM payment;

 avg_amount | stdev_amount 
------------+--------------
       4.20 |         2.37


-- 2) Get the average purchase per employee, as well as the standard
-- deviation.
SELECT staff_id, 
        AVG(amount) as avg_amount, 
        STDDEV(amount) as stdev_amount
FROM payment
GROUP BY staff_id;

 staff_id |     avg_amount     |    stdev_amount    
----------+--------------------+--------------------
        1 | 4.1486725178277564 | 2.3657470940165390
        2 | 4.2524534501642935 | 2.3711618563719162

-- Based on these numbers, do you think there's any meaningful
-- difference between the natural of transactions they handle?

Employee n. 2 handles on average a little bit more amounts (in a bit larger spectrum of values)



-- 3) Get the average purchase for each customer, as well as the standard
-- deviation.

SELECT customer_id, 
        AVG(amount) as avg_amount, 
        STDDEV(amount) as stdev_amount
FROM payment
GROUP BY customer_id;

-- Which customer is the most / least predictable in their behavior?
-- hint: think about standard deviation.

SELECT customer_id, 
        AVG(amount) as avg_amount, 
        STDDEV(amount) as stdev_amount
FROM payment
GROUP BY customer_id
ORDER BY stdev_amount
LIMIT 1;

The most predictable customer (with the min standard deviation) is:

 customer_id |     avg_amount     |    stdev_amount    
-------------+--------------------+--------------------
         330 | 3.3788888888888889 | 1.3779306261410682

SELECT customer_id, 
        AVG(amount) as avg_amount, 
        STDDEV(amount) as stdev_amount
FROM payment
GROUP BY customer_id
ORDER BY stdev_amount DESC
LIMIT 1;

The least predictable customer (with the max standard deviation) is:

 customer_id |     avg_amount     |    stdev_amount    
-------------+--------------------+--------------------
         542 | 5.3025000000000000 | 3.4199171529926472


-- 4) what is the average and standard deviation for the number of 
-- purchases per customer?

WITH total_purchase AS (
    SELECT customer_id, 
        COUNT(amount) as number_of_purchase
    FROM payment
    GROUP BY customer_id
)
    SELECT
        AVG(number_of_purchase) as avg_purchase,
        STDDEV(number_of_purchase) as stdev_purchase 
    FROM total_purchase;

    avg_purchase     |   stdev_purchase   
---------------------+--------------------
 24.3672787979966611 | 5.0919962549346781

-- Based on this, can you say anything about 'typical' customer
-- behavior? (For the sake of this, let's assume all purchases
-- were made in the past year.)
-- Don't need to be super specific about this.

I can say that tipically a customer has a number of purchases between ~19 and ~29


