import numpy as np
from scipy import stats

print("=" * 70)
print("COMPLETE A/B TESTING WORKFLOW - Hypothesis Testing")
print("=" * 70)

# Step 1: Define Hypotheses
print("\n--- STEP 1: DEFINE HYPOTHESES ---")
print("Null Hypothesis (H0): Variant B has NO effect on betting")
print("                      (Mean_B = Mean_A)")
print("Alternative Hypothesis (H1): Variant B INCREASES betting")
print("                             (Mean_B > Mean_A)")
print("Significance level (α): 0.05 (95% confidence)")

# Step 2: Collect Data
print("\n--- STEP 2: COLLECT DATA ---")
variant_a = np.array([50.0, 45.0, 55.0, 48.0, 52.0])
variant_b = np.array([65.0, 70.0, 68.0, 75.0, 72.0])

print(f"Variant A (Control): {variant_a}")
print(f"Variant B (Treatment): {variant_b}")
print(f"Sample size each: {len(variant_a)} users")

# Step 3: Calculate Statistics
print("\n--- STEP 3: CALCULATE STATISTICS ---")
mean_a = variant_a.mean()
mean_b = variant_b.mean()
std_a = variant_a.std()
std_b = variant_b.std()
cv_a = (std_a / mean_a) * 100
cv_b = (std_b / mean_b) * 100

print(f"Mean A: ${mean_a:.2f} (StDev: ${std_a:.2f}, CV: {cv_a:.2f}%)")
print(f"Mean B: ${mean_b:.2f} (StDev: ${std_b:.2f}, CV: {cv_b:.2f}%)")
print(f"Difference: ${mean_b - mean_a:.2f}")
print(f"Percent change: {((mean_b - mean_a) / mean_a) * 100:.1f}%")

# Step 4: Run Statistical Test
print("\n--- STEP 4: RUN STATISTICAL TEST (Independent T-Test) ---")
t_statistic, p_value = stats.ttest_ind(variant_a, variant_b)

print(f"T-statistic: {t_statistic:.4f}")
print(f"P-value: {p_value:.4f}")

# Step 5: Make Decision
print("\n--- STEP 5: MAKE DECISION ---")
alpha = 0.05

if p_value < alpha:
    print(f"✅ REJECT NULL HYPOTHESIS")
    print(f"P-value ({p_value:.4f}) < α ({alpha})")
    print(f"\nConclusion: Variant B is STATISTICALLY SIGNIFICANTLY better!")
    print(f"Confidence level: {(1 - p_value) * 100:.2f}%")
    decision = "LAUNCH VARIANT B 🚀"
else:
    print(f"❌ FAIL TO REJECT NULL HYPOTHESIS")
    print(f"P-value ({p_value:.4f}) >= α ({alpha})")
    print(f"\nConclusion: Difference could be due to random chance.")
    print(f"Recommendation: Collect more data")
    decision = "CONTINUE TESTING 📊"

# Step 6: Business Recommendation
print("\n--- STEP 6: BUSINESS RECOMMENDATION ---")
print(f"Decision: {decision}")
print(f"\nBusiness Impact:")
print(f"- Users in Variant B bet {((mean_b - mean_a) / mean_a) * 100:.1f}% more")
print(f"- Average increase: ${mean_b - mean_a:.2f} per user")
print(f"- With 10,000 users: ${(mean_b - mean_a) * 10000:,.0f} additional revenue!")
print(f"- Statistical confidence: {(1 - p_value) * 100:.2f}%")

print("\n" + "=" * 70)