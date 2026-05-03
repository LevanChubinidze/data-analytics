-- Exercise 1: A/B Testing Basics - Compare two betting interface versions

-- Scenario: We tested two betting interfaces
-- Version A (control): Old interface
-- Version B (treatment): New redesigned interface
-- Question: Which version leads to higher average bets?

-- Create test data (simulating A/B test results)
WITH test_groups AS (
    SELECT 
        1 as user_id,
        'A' as variant,
        50.0 as bet_amount
    UNION ALL
    SELECT 2, 'A', 45.0
    UNION ALL
    SELECT 3, 'A', 55.0
    UNION ALL
    SELECT 4, 'A', 48.0
    UNION ALL
    SELECT 5, 'A', 52.0
    UNION ALL
    SELECT 6, 'B', 65.0
    UNION ALL
    SELECT 7, 'B', 70.0
    UNION ALL
    SELECT 8, 'B', 68.0
    UNION ALL
    SELECT 9, 'B', 75.0
    UNION ALL
    SELECT 10, 'B', 72.0
),

-- Calculate statistics per variant
variant_stats AS (
    SELECT 
        variant,
        COUNT(*) as sample_size,
        AVG(bet_amount) as avg_bet,
--      ROUND(STDEV(bet_amount), 2) as std_dev, We can not use stdev in some SQLile engines, so we will skip it for now
        MIN(bet_amount) as min_bet,
        MAX(bet_amount) as max_bet
    FROM test_groups
    GROUP BY variant
)
SELECT * FROM variant_stats;