"""
Made in India. Priced for India?
Evidence-upgraded analysis outline.

Benchmark: iPhone 17 256GB.
This script uses transparent, user-auditable dictionaries so it can later be
replaced with CSV inputs from the workbook/repository.
"""

import pandas as pd

prices = pd.DataFrame({
    "country": ["India", "China", "Singapore", "United States"],
    "iphone_usd": [1046.7177500462276, 1013.8277792041079, 1144.149547957311, 929.0],
})

consumer_ppp = pd.DataFrame({
    "country": ["India", "China", "Singapore", "United States"],
    "consumer_ppp_per_capita": [7034, 10759, 36838, 58314],
    "reference_year": [2024, 2024, 2024, 2024],
})

aff = prices.merge(consumer_ppp, on="country")
aff["annual_consumption_burden"] = aff["iphone_usd"] / aff["consumer_ppp_per_capita"]
aff["consumption_equivalent_months"] = aff["annual_consumption_burden"] * 12
aff["affordability_rank"] = aff["annual_consumption_burden"].rank(
    ascending=False, method="min"
).astype(int)

print("\nConsumer affordability (core comparable sample)")
print(
    aff.sort_values("affordability_rank")[
        ["country", "iphone_usd", "consumer_ppp_per_capita",
         "annual_consumption_burden", "consumption_equivalent_months",
         "affordability_rank"]
    ].to_string(index=False)
)

# India GST bridge
india_listed_inr = 99_900
india_gst = 0.18
inr_per_usd = 95.44120179063361
us_listed_usd = 929.0

india_pre_gst_inr = india_listed_inr / (1 + india_gst)
india_listed_usd = india_listed_inr / inr_per_usd
india_pre_gst_usd = india_pre_gst_inr / inr_per_usd

print("\nIndia tax bridge")
print(f"India listed: ₹{india_listed_inr:,.0f} = ${india_listed_usd:,.2f}")
print(f"Implied pre-GST: ₹{india_pre_gst_inr:,.0f} = ${india_pre_gst_usd:,.2f}")
print(f"US unlocked list price before state/local sales tax: ${us_listed_usd:,.2f}")
print(f"Listed premium vs US: {(india_listed_usd/us_listed_usd-1):.1%}")
print(f"Tax-normalized premium vs US: {(india_pre_gst_usd/us_listed_usd-1):.1%}")

# India manufacturing timeline
production = pd.DataFrame({
    "fiscal_year": ["FY23", "FY24", "FY25", "FY26"],
    "production_usd_bn": [7.0, 14.0, 22.0, 26.0],
    "note": [">$7B reported; 7 used conservatively", "reported", "reported", "reported"],
})
production["yoy_growth"] = production["production_usd_bn"].pct_change()
overall_multiple = production.iloc[-1]["production_usd_bn"] / production.iloc[0]["production_usd_bn"]

print("\nIndia iPhone manufacturing timeline")
print(production.to_string(index=False))
print(f"Conservative FY23→FY26 production multiple: {overall_multiple:.2f}x")

# Base-model price timeline; 2025 storage shift is explicitly flagged.
price_timeline = pd.DataFrame({
    "year": [2021, 2022, 2023, 2024, 2025, 2026],
    "model": ["iPhone 13", "iPhone 14", "iPhone 15", "iPhone 16", "iPhone 17", "iPhone 17 current"],
    "base_storage": ["128GB", "128GB", "128GB", "128GB", "256GB", "256GB"],
    "price_inr": [79900, 79900, 79900, 79900, 82900, 99900],
})
price_timeline["storage_changed"] = price_timeline["base_storage"].ne(
    price_timeline["base_storage"].shift()
)
price_timeline.loc[price_timeline.index[0], "storage_changed"] = False

print("\nIndia base-model price timeline")
print(price_timeline.to_string(index=False))

print(
    "\nInterpretation: manufacturing scale, nominal list price, tax-normalized price "
    "and affordability are separate analytical layers. Do not infer causation from "
    "their co-movement alone."
)
