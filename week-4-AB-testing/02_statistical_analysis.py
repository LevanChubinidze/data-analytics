import numpy as np
from scipy import stats

# A/B Test Data from our SQL query
variant_a = np.array([50.0, 45.0, 55.0, 48.0, 52.0])
variant_b = np.array([65.0, 70.0, 68.0, 75.0, 72.0])

# Calculate descriptive statistics
print("=" * 60)
print("A/B TEST STATISTICAL ANALYSIS")
print("=" * 60)

print("\n--- VARIANT A (Control) ---")
print(f"Sample size: {len(variant_a)}")
print(f"Mean (average bet): ${variant_a.mean():.2f}")
print(f"Standard deviation: ${variant_a.std():.2f}")
print(f"Min bet: ${variant_a.min():.2f}")
print(f"Max bet: ${variant_a.max():.2f}")

print("\n--- VARIANT B (Treatment) ---")
print(f"Sample size: {len(variant_b)}")
print(f"Mean (average bet): ${variant_b.mean():.2f}")
print(f"Standard deviation: ${variant_b.std():.2f}")
print(f"Min bet: ${variant_b.min():.2f}")
print(f"Max bet: ${variant_b.max():.2f}")

# Calculate the difference
difference = variant_b.mean() - variant_a.mean()
percent_increase = (difference / variant_a.mean()) * 100

print("\n--- COMPARISON ---")
print(f"Difference in means: ${difference:.2f}")
print(f"Percent increase: {percent_increase:.1f}%")

# Perform independent samples t-test
t_statistic, p_value = stats.ttest_ind(variant_a, variant_b)

print("\n--- T-TEST RESULTS ---")
print(f"T-statistic: {t_statistic:.4f}")
print(f"P-value: {p_value:.4f}")

# Interpretation
print("\n--- INTERPRETATION ---")
alpha = 0.05
if p_value < alpha:
    print(f"SIGNIFICANT: p-value ({p_value:.4f}) < 0.05")
    print("Result is statistically significant!")
    print(f"We are 95%+ confident that Variant B is better.")
    print("RECOMMENDATION: Launch Variant B")
else:
    print(f"NOT SIGNIFICANT: p-value ({p_value:.4f}) >= 0.05")
    print("Result could be due to random chance.")
    print("RECOMMENDATION: Need more data or different approach.")

print("\n" + "=" * 60)