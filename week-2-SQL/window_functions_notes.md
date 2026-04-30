# Window Functions - Complete Notes

## ROW_NUMBER() - Assign Sequential Numbers
- Gives each row a unique number: 1, 2, 3, 4...
- Ignores ties (if two users have same bet, still gets different numbers)
- Use case: Get top N rows, latest record per user

### Example
| username | total_bet | ROW_NUMBER |
|----------|-----------|------------|
| anna_k   |    200    |      1     |
| pedro_v  |    150    |      2     |
| alex_g   |    125    |      3     |

---

## RANK() - Handle Ties with Gaps
- Gives tied rows the SAME number
- Skips numbers after ties (1, 1, 1, 4) — like Olympic medals
- Use case: Sports leaderboards, competition rankings

### Example (with ties at 100)
| username | total_bet | RANK |
|----------|-----------|------|
| alex_g   |    100    |   1  |
| maria_s  |    100    |   1  |
| pedro_v  |    100    |   1  |
| john_d   |     50    |   4  |

---

## DENSE_RANK() - Handle Ties without Gaps
- Gives tied rows the SAME number
- Does NOT skip numbers (1, 1, 1, 2) — no gaps
- Use case: Product rankings, performance tiers

### Example (with ties at 100)
| username | total_bet | DENSE_RANK |
|----------|-----------|------------|
| alex_g   |    100    |     1      |
| maria_s  |    100    |     1      |
| pedro_v  |    100    |     1      |
| john_d   |     50    |     2      |

---

## OVER() - The Window Frame
- Defines **HOW** the function calculates
- `OVER (ORDER BY column DESC)` — order rows before calculating
- `OVER ()` — calculate across entire result set
- Without OVER: window functions don't work

---

## PARTITION BY - Separate Groups
- Treats each group independently
- `PARTITION BY user_id` — each user gets their own calculation window
- Without it: All data mixed together (usually wrong!)

### Example
User alex_g bets: 50 → 30 → 45
| amount |  LAG  | LEAD |
|--------|-------|------|
|   50   |  NULL |  30  |
|   30   |  50   |  45  |
|   45   |  30   | NULL |

---

## LAG() - Previous Row Value
- Access the **previous row's** value within a partition
- `LAG(column) OVER (PARTITION BY user_id ORDER BY date)`
- Returns **NULL** for first row (no previous row)
- Use case: "Did they increase betting?" "Compare week-to-week?"

---

## LEAD() - Next Row Value
- Access the **next row's** value within a partition
- `LEAD(column) OVER (PARTITION BY user_id ORDER BY date)`
- Returns **NULL** for last row (no next row)
- Use case: "Predict next action?" "Gap detection?"

---

## SUM() OVER() - Running Total (Cumulative Sum)
- Calculates cumulative sum from first row to current row
- `SUM(amount) OVER (PARTITION BY user_id ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)`
- Use case: "Total spending over time?" "Show betting trends?"

### Example
User alex_g bets: 50 → 30 → 45
| bet_date   | amount | cumulative_bet |
|------------|--------|----------------|
| 2024-03-01 |   50   |      50        |
| 2024-03-02 |   30   |      80        |
| 2024-03-05 |   45   |     125        |

Each row shows running total from first bet to current bet.

### ROWS BETWEEN Keywords
- `UNBOUNDED PRECEDING` — start from first row
- `CURRENT ROW` — stop at this row
- `N PRECEDING` — include last N rows
- `N FOLLOWING` — include next N rows

### Common Combinations
```sql
-- Running total (first row to current)
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW

-- Moving average (last 3 rows)
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW

-- All rows in partition
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
```

---

## Complete Example
```sql
SELECT 
    username,
    bet_date,
    amount,
    ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank,
    LAG(amount) OVER (PARTITION BY user_id ORDER BY bet_date) AS prev_bet,
    LEAD(amount) OVER (PARTITION BY user_id ORDER BY bet_date) AS next_bet,
    SUM(amount) OVER (PARTITION BY user_id ORDER BY bet_date 
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative
FROM bets;
```

Result: **every row shows rank + previous amount + next amount + running total in ONE query!**

---