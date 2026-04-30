-- Exercise 3: LAG and LEAD - compare each bet to previous/next bet
SELECT 
    u.username,
    b.bet_date,
    b.amount,
    LAG(b.amount) OVER (PARTITION BY u.user_id ORDER BY b.bet_date) AS previous_bet,
    LEAD(b.amount) OVER (PARTITION BY u.user_id ORDER BY b.bet_date) AS next_bet
FROM users u
JOIN bets b ON u.user_id = b.user_id
ORDER BY u.username, b.bet_date;