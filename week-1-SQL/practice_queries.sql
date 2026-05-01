-- PRACTICE SQL QUERIES
-- Week 1 SQL Practice 

-- ============================================
-- Exercise 1: Show all users from Spain
-- ============================================
SELECT * FROM users
WHERE country = 'Spain';


-- ============================================
-- Exercise 2: Count how many users registered per country
-- ============================================
SELECT country, COUNT(*) AS num_users
FROM users
GROUP BY country;


-- ============================================
-- Exercise 3: Find the total amount bet per user
-- (hint: use SUM and GROUP BY)
-- ============================================
SELECT user_id, SUM(amount) AS total_bet
FROM bets   
GROUP BY user_id;


-- ============================================
-- Exercise 4: Show each user's username alongside their total bets
-- (hint: you need to JOIN users and bets tables)  
-- ============================================
SELECT u.username, SUM(b.amount) AS total_bet
FROM users u
JOIN bets b ON u.id = b.user_id
GROUP BY u.username;


-- ============================================
-- Exercise 5: Show only users who have placed more than 1 bet,
-- with their username and total bet amount
-- (hint: use HAVING)
-- ============================================
SELECT u.username, SUM(b.amount) AS total_bet
FROM users u
JOIN bets b ON u.user_id = b.user_id
GROUP BY u.username
HAVING COUNT(b.bet_id) > 1;


-- ============================================
-- Exercise 6: Show each user's username, country, total amount bet,
-- and total session time (duration_minutes)
-- Hint: you need to JOIN all 3 tables
-- ============================================
SELECT 
    u.username, 
    u.country, 
    b.total_amount_bet, 
    s.total_session_time
FROM users u
JOIN (SELECT user_id, SUM(amount) AS total_amount_bet 
        FROM bets GROUP BY user_id) b ON u.user_id = b.user_id
JOIN (SELECT user_id, SUM(duration_minutes) AS total_session_time 
        FROM sessions GROUP BY user_id) s ON u.user_id = s.user_id;


-- ============================================
-- Exercise 7: Show the top 3 countries by total amount bet,
-- ordered from highest to lowest.
-- Hint: you need country from users, amount from bets,
-- and a new keyword: ORDER BY and LIMIT
-- ============================================
SELECT
    u.country, 
    SUM(b.amount) AS total_bet
FROM users u
JOIN bets b ON u.user_id = b.user_id
GROUP BY u.country
ORDER BY total_bet DESC
LIMIT 3;


-- ============================================
-- Exercise 8: Show each game type with:
-- total bets placed, total amount bet, and win rate (% of bets that were wins)
-- Order by total amount bet descending
-- Hint: for win rate use:
-- ROUND(100.0 * SUM(CASE WHEN result = 'win' THEN 1 ELSE 0 END) / COUNT(*), 1)
-- ============================================
SELECT 
    game,
    COUNT(*) AS total_bets, 
    SUM(amount) AS total_amount_bet,
    ROUND(100.0 * SUM(CASE WHEN result = 'win' THEN 1 ELSE 0 END) / COUNT(*), 1) AS win_rate
FROM bets
GROUP BY game
ORDER BY total_amount_bet DESC;

-- ============================================