-- Week 3: 
-- CTE (Common Table Expression) is a powerful SQL feature that allows you to create temporary result 
-- sets that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement. 
-- Below are the solutions for the exercises related to CTEs.

-- ============================================
-- Exercise 1: Basic CTE - Calculate user totals and filter
-- ============================================
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


-- ============================================
--Exercise 2: Multiple CTEs - Build step by step
-- ============================================

-- Step 1: CTE to Calculate user totals
WITH user_totals AS (
    SELECT 
        u.user_id, 
        u.username, 
        u.country,
        SUM(b.amount) AS total_amount_bet
    FROM users u
    JOIN bets b ON u.user_id = b.user_id
    GROUP BY u.user_id, u.username, u.country
),

-- Step 2: Ranking users by total  bet
ranked_users AS (
    SELECT 
        user_id, 
        username, 
        country,
        total_amount_bet,
        RANK() OVER (ORDER BY total_amount_bet DESC) AS bet_rank
    FROM user_totals
)

-- Step 3: Select the final result, Get top 3 users
SELECT * From ranked_users
WHERE bet_rank <= 3;

-- ============================================
-- Exercise 3: Recursive CTE - Generate betting sequence
-- ============================================

-- Show cumulative bets for a user over time, simulating a betting streak
WITH RECURSIVE bet_sequence AS (

    -- BASE CASE: Start with the first bet
    SELECT 
        user_id,
        1 as bet_number,
        50.0 as bet_amount,
        50.0 as cumulative_amount
    FROM users
    WHERE user_id = 1
    
    UNION ALL
    
    -- RECURSIVE CASE: Keep adding bets (multiply by 1.5 each time)
    SELECT 
        user_id,
        bet_number + 1,
        bet_amount * 1.5,
        cumulative_amount + (bet_amount * 1.5)
    FROM bet_sequence
    WHERE bet_number < 10  -- Stop after 10 bets in sequence
)
SELECT * FROM bet_sequence
ORDER BY bet_number;