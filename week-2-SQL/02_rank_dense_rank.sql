-- Exercise 2: Difference between ROW_NUMBER, RANK and DENSE_RANK
SELECT 
    u.username,
    SUM(b.amount) AS total_bet,
    ROW_NUMBER() OVER (ORDER BY SUM(b.amount) DESC) AS row_num,
    RANK() OVER (ORDER BY SUM(b.amount) DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY SUM(b.amount) DESC) AS dense_rank
FROM users u
JOIN bets b ON u.user_id = b.user_id
GROUP BY u.username;