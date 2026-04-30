-- Exercise 4: Running Total - cumulative bet amount per user over time
SELECT 
    u.username,
    b.bet_date,
    b.amount,
    SUM(b.amount) OVER (
        PARTITION BY u.user_id 
        ORDER BY b.bet_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_bet
FROM users u
JOIN bets b ON u.user_id = b.user_id
ORDER BY u.username, b.bet_date;