# CTEs (Common Table Expressions) - Complete Notes

## What is a CTE?
A CTE is a **temporary named result set** that exists only for the duration of a query. Think of it as a named subquery that makes complex queries readable.

Instead of nested subqueries that are hard to follow, CTEs let you build queries step-by-step.

---

## Basic CTE Syntax

```sql
WITH cte_name AS (
    SELECT ... FROM ...
)
SELECT * FROM cte_name;
```

**Key points:**
- `WITH` keyword starts the CTE
- `cte_name AS (...)` defines the temporary table
- Everything inside the parentheses is the query
- You then use `cte_name` like a regular table

---

## Why Use CTEs?

### 1. Readability
**Without CTE (hard to read):**
```sql
SELECT * FROM (
    SELECT * FROM (
        SELECT user_id, SUM(amount) FROM bets GROUP BY user_id
    ) WHERE total > 100
) WHERE rank <= 3;
```

**With CTE (clean and clear):**
```sql
WITH user_totals AS (
    SELECT user_id, SUM(amount) as total FROM bets GROUP BY user_id
)
SELECT * FROM user_totals WHERE total > 100;
```

### 2. Reusability
You can reference the same CTE multiple times in one query:
```sql
WITH high_value_users AS (
    SELECT user_id, SUM(amount) as total FROM bets GROUP BY user_id
)
SELECT * FROM high_value_users WHERE total > 1000
UNION ALL
SELECT * FROM high_value_users WHERE total < 50;
```

### 3. Maintainability
Change the CTE once, and the entire query updates. No need to modify nested subqueries in multiple places.

---

## Multiple CTEs (Chaining)

You can create multiple CTEs in one query:

```sql
WITH cte1 AS (
    SELECT ... FROM ...
),
cte2 AS (
    SELECT ... FROM cte1  ← references cte1
),
cte3 AS (
    SELECT ... FROM cte2  ← references cte2
)
SELECT * FROM cte3;  ← or from any CTE above
```

**Execution order:** top-to-bottom. Each CTE can reference all CTEs above it.

---

## Real Analyst Example: Multiple CTEs

**Problem:** Show top 3 users by total bets, including their country.

```sql
WITH user_totals AS (
    -- Step 1: Calculate each user's total
    SELECT 
        u.user_id,
        u.username,
        u.country,
        SUM(b.amount) AS total_amount_bet
    FROM users u
    JOIN bets b ON u.user_id = b.user_id
    GROUP BY u.user_id, u.username, u.country
),
ranked_users AS (
    -- Step 2: Rank by total
    SELECT 
        user_id,
        username,
        country,
        total_amount_bet,
        ROW_NUMBER() OVER (ORDER BY total_amount_bet DESC) AS rank
    FROM user_totals
)
-- Step 3: Filter to top 3
SELECT * FROM ranked_users WHERE rank <= 3;
```

**Result:**
| username  | country | total_amount_bet| rank |
|-----------|---------|-----------------|------|
| anna_k    | UK      | 200             |   1  |
| pedro_v   | Spain   | 150             |   2  |
| alex_g    | Spain   | 125             |   3  |

---

## Recursive CTEs

A recursive CTE references **itself** to generate sequences or hierarchies.

### Syntax

```sql
WITH RECURSIVE cte_name AS (
    -- ANCHOR (base case): starting point
    SELECT ... WHERE condition
    
    UNION ALL
    
    -- RECURSIVE MEMBER: calls itself
    SELECT ... FROM cte_name WHERE stop_condition
)
SELECT * FROM cte_name;
```

**Two required parts:**

1. **Anchor member** — the base case, provides initial rows
2. **Recursive member** — references the CTE itself, adds more rows
3. **Stop condition** — WHERE clause that prevents infinite loops

---

## Recursive CTE Example: Sequence Generation

Generate numbers 1 to 5:

```sql
WITH RECURSIVE numbers AS (
    -- Anchor: start at 1
    SELECT 1 as n
    
    UNION ALL
    
    -- Recursive: keep adding 1
    SELECT n + 1 FROM numbers WHERE n < 5
)
SELECT * FROM numbers;
```

**Execution:**
- Iteration 1: Anchor produces      `n=1`
- Iteration 2: Recursive produces   `n=2` (from n=1)
- Iteration 3: Recursive produces   `n=3` (from n=2)
- Iteration 4: Recursive produces   `n=4` (from n=3)
- Iteration 5: Recursive produces   `n=5` (from n=4)
- Iteration 6: Would produce        `n=6`, but `WHERE n < 5` stops it

**Result:** 1, 2, 3, 4, 5

---

## Real Analyst Example: Recursive CTE

**Problem:** Simulate a betting streak where each bet is 1.5x the previous bet.

```sql
WITH RECURSIVE bet_sequence AS (
    -- Anchor: first bet is 50
    SELECT 
        1 as bet_number,
        50.0 as bet_amount,
        50.0 as cumulative_amount
    
    UNION ALL
    
    -- Recursive: each bet is 1.5x previous
    SELECT 
        bet_number + 1,
        bet_amount * 1.5,
        cumulative_amount + (bet_amount * 1.5)
    FROM bet_sequence
    WHERE bet_number < 10  -- Stop after 10 bets
)
SELECT * FROM bet_sequence;
```

**Result shows exponential growth:**
| bet_number | bet_amount | cumulative_amount |
|------------|------------|-------------------|
| 1          | 50.00      | 50.00             |
| 2          | 75.00      | 125.00            |
| 3          | 112.50     | 237.50            |
| 4          | 168.75     | 406.25            |
| 5          | 253.13     | 659.38            |
| ...        | ...        | ...               |
| 10         | 1922.17    | 5666.50           |

---

## When to Use Recursive CTEs

**Good use cases:**
- Generating sequences (1 to N)
- Hierarchical data (org charts, categories)
- Path finding in graphs
- Financial forecasting (what-if scenarios)

**Avoid when:**
- Simple aggregations (use regular CTE instead)
- Large datasets (can be slow)
- Better solved with window functions

---

## CTE vs Subquery vs Temp Table

| Feature       | CTE           | Subquery  | Temp Table      |
|---------------|---------------|-----------|-----------------|
| Readability   | High          | Low       | Medium          |
| Reusability   | Multiple times| Once only | Multiple queries|
| Performance   | Good          | OK        | Good            |
| Complexity    | Easy          | Medium    | High setup      |

**Recommendation:** Use CTEs for most analyst work. They're the Goldilocks of SQL — easy to read, reusable, performant.

---

## Best Practices

1. **Name CTEs clearly:** `WITH user_totals AS` not `WITH t1 AS`
2. **Order logically:** Build from simple to complex
3. **Comment each CTE:** What does it calculate?
4. **Use consistent formatting:** Indent the SELECT inside each CTE
5. **Add UNION ALL carefully:** Recursive CTEs need it for looping
6. **Test incrementally:** Run each CTE individually to debug

---

## Common Mistakes

**Mistake 1: Circular reference**
```sql
WITH a AS (SELECT * FROM b),
     b AS (SELECT * FROM a)  -- Error! b doesn't exist yet
```

**Fix:** CTEs execute top-to-bottom. Reference only CTEs above.

---

**Mistake 2: Infinite recursion**
```sql
WITH RECURSIVE nums AS (
    SELECT 1 as n
    UNION ALL
    SELECT n + 1 FROM nums  -- No WHERE clause = infinite loop!
)
```

**Fix:** Always include a STOP condition in WHERE clause.

---

**Mistake 3: Missing UNION ALL in recursion**
```sql
WITH RECURSIVE nums AS (
    SELECT 1 as n
    UNION  -- Missing ALL!
    SELECT n + 1 FROM nums WHERE n < 5
)
```

**Fix:** Use `UNION ALL` for recursive CTEs (keeps duplicates needed for recursion).

---

## Quick Reference

| Task                          | Syntax                                                            |
|-------------------------------|-------------------------------------------------------------------|
| Basic CTE                     | `WITH name AS (...) SELECT * FROM name;`                          |
| Multiple CTEs                 | `WITH a AS (...), b AS (...), c AS (...) SELECT ...;`             |
| CTE with JOIN                 | `WITH cte AS (...) SELECT * FROM cte JOIN other_table ON ...;`    |
| Recursive CTE                 | `WITH RECURSIVE name AS (anchor UNION ALL recursive) SELECT ...;` |
| Reference CTE multiple times  | `SELECT * FROM cte UNION SELECT * FROM cte WHERE ...;`            |

---

## Your Learning Path

**Week 3 completed:**
- Basic CTE (single step) — Exercise 1
- Multiple CTEs (chained) — Exercise 2
- Recursive CTE (sequences) — Exercise 3
