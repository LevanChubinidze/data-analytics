-- WINDOW FUNCTIONS - COMPLETE SOLUTIONS
-- Week 2 SQL Practice

-- ============================================
-- Exercise 1: ROW_NUMBER
-- ============================================
SELECT 
    u.username,
    SUM(b.amount) AS total_bet,
    ROW_NUMBER() OVER (ORDER BY SUM(b.amount) DESC) AS rank
FROM users u
JOIN bets b ON u.user_id = b.user_id
GROUP BY u.username;

-- ============================================
-- Exercise 2: RANK vs DENSE_RANK
-- ============================================
SELECT 
    u.username,
    SUM(b.amount) AS total_bet,
    ROW_NUMBER() OVER (ORDER BY SUM(b.amount) DESC) AS row_num,
    RANK() OVER (ORDER BY SUM(b.amount) DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY SUM(b.amount) DESC) AS dense_rank
FROM users u
JOIN bets b ON u.user_id = b.user_id
GROUP BY u.username;

-- ============================================
-- Exercise 3: LAG and LEAD
-- ============================================
SELECT 
    u.username,
    b.bet_date,
    b.amount,
    LAG(b.amount) OVER (PARTITION BY u.user_id ORDER BY b.bet_date) AS previous_bet,
    LEAD(b.amount) OVER (PARTITION BY u.user_id ORDER BY b.bet_date) AS next_bet
FROM users u
JOIN bets b ON u.user_id = b.user_id
ORDER BY u.username, b.bet_date;

-- ============================================
-- Exercise 4: Running Total
-- ============================================
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