# Data Dictionary

| File | Grain | Main use |
|---|---|---|
| country_prices.csv | one row per country | nominal cross-country pricing |
| consumer_affordability.csv | one row per core country | primary affordability analysis |
| gdp_ppp_robustness.csv | one row per country | secondary robustness check |
| tax_normalization.csv | one row per country | directional VAT/GST normalization |
| india_manufacturing.csv | one row per manufacturing metric | production/export/localization KPIs |
| india_production_timeline.csv | one row per FY | production growth chart |
| india_price_timeline.csv | one row per iPhone year/current snapshot | India price timeline |
| device_tco_baseline.csv | one row per device | iPhone vs Galaxy TCO |
| tco_scenarios.csv | one row per scenario | ownership sensitivity |
| resale_sensitivity.csv | one row per resale combination | Power BI heatmap |
| source_registry.csv | one row per key source | evidence/audit trail |

### Important fields
- `evidence_type`: whether the figure is reported, calculated, or modeled.
- `normalization_status`: whether a country was tax-normalized or intentionally held out.
- `comparability_note`: flags storage or methodology changes that make time comparisons imperfect.
