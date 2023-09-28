-- 1
CREATE VIEW rental_sum AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    COUNT(r.rental_id) AS rental_count
FROM
    customer c
LEFT JOIN
    rental r ON c.customer_id = r.customer_id
GROUP BY
    c.customer_id, c.email;
-- 2
CREATE TEMPORARY TABLE payment_summ AS
SELECT
    r.customer_id,
    SUM(p.amount) AS total_paid
FROM
    rental_summary r
LEFT JOIN
    payment p ON r.customer_id = p.customer_id
GROUP BY
    r.customer_id;
-- 3
WITH customer_summ_cte AS (
    SELECT
        rs.customer_name,
        rs.email,
        rs.rental_count,
        ps.total_paid,
        ps.total_paid / rs.rental_count AS average_payment_per_rental
    FROM
        rental_summ rs
    LEFT JOIN
        payment_summ ps ON rs.customer_id = ps.customer_id
)

-- Finally, use the CTE to generate the customer summary report:
SELECT
    customer_name,
    email,
    rental_count,
    total_paid,
    average_payment_per_rental
FROM
    customer_summ_cte;

