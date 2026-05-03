# A/B Testing & Statistics - Complete Notes

## What is A/B Testing?

**Definition:** Compare two versions (A = control, B = treatment) to determine which performs better using statistical analysis.

**Real gambling example:**
- Version A: Old betting interface
- Version B: New betting interface redesign
- Question: Does the new design increase average bet amounts?

---

## The A/B Testing Workflow

### Step 1: Define Hypotheses

**Null Hypothesis (H₀):** "There is NO difference between variants"
- Variant B has NO effect on user behavior
- Mean_B = Mean_A

**Alternative Hypothesis (H₁):** "There IS a difference"
- Variant B increases/decreases user behavior
- Mean_B ≠ Mean_A (two-tailed) OR Mean_B > Mean_A (one-tailed)

**Significance Level (α):** 0.05
- Standard threshold in industry
- Means 95% confidence level
- 5% acceptable error rate

---

### Step 2: Collect Data

**Requirements:**
- Random assignment (users randomly see A or B)
- Sufficient sample size (not just 5 users!)
- Representative population
- Same time period

Variant A (Control):    [50. 45. 55. 48. 52.]
Variant B (Treatment):  [65. 70. 68. 75. 72.]
Sample size each: 5 users

---

### Step 3: Calculate Descriptive Statistics

**Key metrics:**

| Metric    |       Formula        |        Meaning         |
|-----------|----------------------|------------------------|
| Mean      | Sum / Count          | Average value          |
| StDev     | √(Variance)          | How spread out data is |
| Min/Max   | Smallest/Largest     | Data range             |
| CV%       | (StDev / Mean) × 100 | Relative variation     |

Mean A: $50.00 (StDev: $3.41, CV: 6.81%)
Mean B: $70.00 (StDev: $3.41, CV: 4.87%)
Difference: $20.00 **(40.0% Increase)**

---

## Standard Deviation (StDev) - Deep Dive

### What It Measures
How spread out data points are from the average.

### Calculation Steps

**Given data:** $50, $45, $55, $48, $52 (Average: $50)
- 1. *Find distance from average:*
- $50   -   $50   =   $0, 
- $45   -   $50   =   -$5, 
- $55   -   $50   =   $5, 
- $48   -   $50   =   -$2, 
- $52   -   $50   =   $2
  
- 2. *Square each distance:*
- $0²   =   $0, 
- (-$5)²=   $25, 
- ($5)² =   $25, 
- (-$2)²=   $4, 
- ($2)² =   $4
  
- 3. *Average the squared distances:*
- ($0 + $25 + $25 + $4 + $4) / 5 = **$11.6**

- 4. *Take square root:*
- √$11.6 = $3.41

### Interpreting StDev

**Rule of 68-95-99.7:**
- ±1 StDev: covers ~68% of data
- ±2 StDev: covers ~95% of data
- ±3 StDev: covers ~99.7% of data

**Mean: $50, StDev: $3.41**
- ±1 StDev: $46.59 to $53.41 (68% of bets)
- ±2 StDev: $43.18 to $56.82 (95% of bets)
  
---

## Coefficient of Variation (CV%)

### What It Is
**Relative measure of variation** — compares StDev to the mean as a percentage.

- CV% = (StDev / Mean) × 100
  
### Interpreting CV%

| CV% Range |   Consistency     | Data Quality |  Sample Size  |
|-----------|-------------------|--------------|---------------|
|   0-10%   | Very consistent   | Excellent    | 30-50 users   |
|   10-20%  | Consistent        | Good         | 50-100 users  |
|   20-30%  | Moderate variation| Fair         | 100-200 users |
|   30-50%  | High variation    | Poor         | 200-500 users |
|   50%+    | Very unreliable   | Bad          | 500+ users    |

- Variant A: CV = 6.81% (excellent consistency, 30-50 users needed)
- Variant B: CV = 4.87% (excellent consistency, 30-50 users needed)

---

## Statistical Hypothesis Testing

### The T-Test (Student's t-test)

**Purpose:** Compare the means of two groups to see if they're significantly different.

**When to use:**
- Comparing two groups
- Continuous data (betting amounts, time spent, etc.)
- Small to medium samples

### How T-Test Works

1. Calculate difference between means
2. Calculate how "spread out" each group is (StDev)
3. Calculate t-statistic: measures if difference is large compared to variation
4. Compare to threshold distribution
5. Get p-value

**Formula (simplified):**
- t = (Mean_B - Mean_A) / Standard Error
- 1. 70 - 50 = 20 
- *Calculate Combined Standard Error* 
- A = 3.41 / √(n) = 3.41 / √5 = 3.41 / 2.24 = 1.525
- B = 3.41 / √(n) = 3.41 / √5 = 3.41 / 2.24 = 1.525
- SE_combined = √(SE_A² + SE_B²)
- SE Combined = √(1.525² + 1.525²)
- 2. SE Combined = 2.16 (Approx)

---

## P-Value (Probability Value)

### What It Means

**P-value = probability that the observed difference happened by pure random chance** (if there's actually no real difference).

### Interpreting P-Values

p-value = 0.01 (1%)
→ Only 1% chance this happened by luck
→ 99% confident it's real
→ SIGNIFICANT ✅

p-value = 0.05 (5%)
→ 5% chance of random luck
→ 95% confident it's real
→ BORDERLINE ⚠️

p-value = 0.50 (50%)
→ 50% chance of random luck
→ Likely just noise
→ NOT SIGNIFICANT ❌

### The Magic Threshold: α = 0.05

**Industry standard:** p-value < 0.05 means **statistically significant**

p-value < 0.05  → Result is REAL, reject H₀ ✅
p-value ≥ 0.05  → Could be luck, fail to reject H₀ ❌

✅ REJECT NULL HYPOTHESIS
P-value (0.0000) < α (0.05)

p-value = 0.0000
This is < 0.05, so result is SIGNIFICANT ✅
Only 0.00% chance this happened by random luck!

---

## Decision Making Process

### Step 5: Make Statistical Decision

Compare p-value to α (0.05):

IF p-value < 0.05:
→ REJECT NULL HYPOTHESIS
→ Variant B IS significantly different
→ Result is REAL, not luck

IF p-value ≥ 0.05:
→ FAIL TO REJECT NULL HYPOTHESIS
→ Difference could be random
→ Need more data

### Step 6: Translate to Business Decision

**Once you reject H₀:**

1. **Effect size:** How big is the difference? 
Your case: 40% increase ($20 on $50)
Very large!

2. **Practical significance:** Does it matter for business?
$20 per user × 10,000 users = $200,000 revenue
YES, it matters!

3. **Confidence level:** How sure are you?
p = 0.0000 → 100% confidence
Very high! ✅

4. **Final recommendation:**
*LAUNCH VARIANT* **B**

---

## Sample Size & Statistical Power

### Why Sample Size Matters

**Larger sample = easier to detect real effects**
Low     CV (6.8%):  Need 30-50      users per group
High    CV (35%):   Need 100-200    users per group

### Rule of Thumb

CV < 10%  → 30-50   users per group
CV 10-20% → 50-100  users per group
CV 20-30% → 100-200 users per group
CV > 30%  → 200+    users per group

**Why?** High variation = harder to spot signal from noise

---

## Common Mistakes in A/B Testing

**Mistake 1: Stopping test early when you see a winner**
- Called "peeking" at results
- Increases false positive rate
- Always run to predetermined sample size

✅ **Fix:** Decide sample size BEFORE running test

---

**Mistake 2: Changing the hypothesis after seeing results**
- Called "p-hacking"
- Cherry-picking significant results
- Inflates false positives

✅ **Fix:** Define hypotheses BEFORE collecting data

---

**Mistake 3: Running multiple tests without correction**
- Multiple comparisons problem
- Each test has 5% error rate
- 10 tests = cumulative error!

✅ **Fix:** Use Bonferroni correction or Benjamini-Hochberg

---

**Mistake 4: Ignoring practical significance**
- Example: p=0.02 (statistically significant)
- But effect size: 0.1% increase ($0.05 on $50)
→ Not worth implementing!

✅ **Fix:** Always check effect size AND p-value

---

## Quick Reference: A/B Test Results

|       Metric   |      Value       |       Interpretation      |
|----------------|------------------|---------------------------|
|   Mean A       |      $50.00      | Control average           |
|   Mean B       |      $70.00      | Treatment average         |
|   Difference   | $20.00 (40%)     | Large effect!             |
|   StDev A      | $3.41 (6.81% CV) | Very consistent           |
|   StDev B      | $3.41 (4.87% CV) | Very consistent           |
|   T-statistic  |      -8.3045     | Large difference          |
|   P-value      |      0.0000      | Highly significant        |
|   Decision     |      REJECT H₀   | Variant B is better       |
|   Confidence   |      100%        | Extremely confident       |
| Recommendation |      LAUNCH B    | Implement now             |
| Revenue Impact | $200K (10K users)| Significant business value|

---

## Tools Used

**SQL:** Define and prepare test data, calculate aggregates
**NumPy:** Calculate statistics (mean, std, min, max)
**SciPy:** Run statistical tests (t-test, p-value)
**Python:** Full workflow automation

---

## Real-World Applications

✅ **E-commerce:** Button color A vs B → conversion rate
✅ **Betting/Gaming:** New UI A vs old UI B → average bet
✅ **Social media:** Feed algorithm A vs B → engagement
✅ **SaaS:** Pricing plan A vs B → subscription rate
✅ **Healthcare:** Treatment A vs treatment B → patient outcomes

---

## Learning Path

✅ **Exercise 1:** SQL data preparation and descriptive stats
✅ **Exercise 2:** Python statistics and t-test
✅ **Exercise 3:** Full hypothesis testing workflow

**Next:** Apply this to real business problems!