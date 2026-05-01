--Exercise 2: Multiple CTEs - Build step by step

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