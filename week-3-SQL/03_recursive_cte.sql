-- Exercise 3: Recursive CTE - Generate betting sequence

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