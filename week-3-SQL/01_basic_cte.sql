-- Exercise 1: Basic CTE - Calculate user totals and filter

WITH user_totals AS (
    SELECT 
        u.user_id, 
        u.username, 
        SUM(b.amount) AS total_amount_bet
    FROM users u
    JOIN bets b ON u.user_id = b.user_id
    GROUP BY u.user_id, u.username
)
SELECT * FROM user_totals
WHERE total_amount_bet > 100;