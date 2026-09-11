# Power BI Implementation Pack

## Import order
Import every CSV in the `data` folder with **Get Data → Text/CSV**.

Rename queries to match the CSV filenames without `.csv`:
- country_prices
- consumer_affordability
- gdp_ppp_robustness
- tax_normalization
- india_manufacturing
- india_production_timeline
- india_price_timeline
- device_tco_baseline
- tco_scenarios
- resale_sensitivity
- source_registry

## Recommended data types
- Currency / price fields: Decimal Number or Fixed Decimal Number
- Rates / burden / resale fields: Decimal Number, formatted as Percentage
- Years: Whole Number
- snapshot_date: Date
- URLs / evidence / caveats: Text

## Relationships
Do **not** force a complex model. This project is small and analysis-specific.

Create a one-column `DimCountry` table from distinct countries if you want a shared country slicer:
```DAX
DimCountry =
DISTINCT (
    UNION (
        SELECTCOLUMNS ( country_prices, "country", country_prices[country] ),
        SELECTCOLUMNS ( consumer_affordability, "country", consumer_affordability[country] ),
        SELECTCOLUMNS ( tax_normalization, "country", tax_normalization[country] )
    )
)
```

Relationships:
- DimCountry[country] 1:* country_prices[country]
- DimCountry[country] 1:* consumer_affordability[country]
- DimCountry[country] 1:* tax_normalization[country]

Keep the India timeline, manufacturing and TCO tables disconnected unless a visual specifically needs a relationship.

## Page 1 — Pricing Paradox
Cards:
- India Listed Price USD
- India Premium vs US
- India Nominal Rank
- Selected Market Count

Main visual:
- Horizontal bar: country_prices[country] vs country_prices[usd_equivalent]
- Sort descending.
- Use a conditional-format measure or manual visual emphasis for India.

Subtitle:
**India is not the most expensive selected market. The next question is affordability.**

## Page 2 — Affordability
Cards:
- India Consumer Months
- US Consumer Months
- India vs US Burden Multiple

Visual 1:
- Bar chart: consumer_affordability[country] vs consumption_equivalent_months

Visual 2:
- Scatter: X = iphone_price_usd; Y = annual_consumption_burden; Details = country

Small secondary visual:
- gdp_ppp_robustness as a robustness check, clearly labelled secondary.

Caveat:
**Household-consumption PPP is a macro spending proxy, not salary or disposable income.**

## Page 3 — Made in India
Cards:
- FY26 Production USD Bn
- FY26 Export USD Bn
- FY26 Export Share
- Apple India Value Add Avg

Visual 1:
- Column chart: fiscal_year vs production_usd_bn

Visual 2:
- Line chart: india_price_timeline[year] vs india_price_inr

Annotation:
**iPhone 17 moved to 256GB base storage, so 2025 vs earlier base models is not pure like-for-like inflation.**

## Page 4 — Ownership Economics
Cards:
- iPhone Purchase Price INR
- Galaxy Purchase Price INR
- iPhone Monthly TCO INR
- Galaxy Monthly TCO INR
- iPhone BreakEven Resale Rate

Visual 1:
- Clustered bars: device vs purchase price / net ownership cost

Visual 2:
- Matrix heatmap from resale_sensitivity:
  Rows = iphone_resale_rate
  Columns = galaxy_resale_rate
  Values = iphone_minus_galaxy_monthly_inr
  Conditional formatting: negative favourable to iPhone; positive favourable to Galaxy.

Visual 3:
- Scenario bar: tco_scenarios[scenario] vs monthly_cost_inr

## Evidence design
Add a small footer on every page:
**Reported = published source | Calculated = arithmetic from reported data | Modeled = scenario assumption**

Do not hide the distinction between reported and modeled values.

## Final page order
1. Pricing
2. Affordability
3. Manufacturing & localization
4. Total cost of ownership

That order matches the analytical narrative:
**Price → Purchasing power → Production economics → Consumer decision.**
