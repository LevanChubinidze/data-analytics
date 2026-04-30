-- Exercise 1: Rank users by total amount bet (highest first)
-- using ROW_NUMBER window function

SELECT 
    u.username,
    SUM(b.amount) AS total_bet,
    ROW_NUMBER() OVER (ORDER BY SUM(b.amount) DESC) AS rank
FROM users u
JOIN bets b ON u.user_id = b.user_id
GROUP BY u.username;