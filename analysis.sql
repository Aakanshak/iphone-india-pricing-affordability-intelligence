-- Made in India. Priced for India?
-- Portfolio SQL analysis plan
-- Benchmark remains iPhone 17 256GB.
-- Derived values should retain evidence/status fields.

-- 1) Nominal country price ranking
SELECT
    country,
    usd_equivalent,
    premium_vs_us,
    RANK() OVER (ORDER BY usd_equivalent DESC) AS price_rank_high_to_low
FROM country_prices
WHERE model = 'iPhone 17' AND storage = '256GB'
ORDER BY usd_equivalent DESC;

-- 2) Primary consumer-affordability ranking
-- consumer_ppp_per_capita = household final consumption expenditure per capita, PPP.
SELECT
    p.country,
    p.usd_equivalent,
    a.consumer_ppp_per_capita,
    p.usd_equivalent / a.consumer_ppp_per_capita AS annual_consumption_burden,
    (p.usd_equivalent / a.consumer_ppp_per_capita) * 12 AS consumption_equivalent_months,
    RANK() OVER (
        ORDER BY p.usd_equivalent / a.consumer_ppp_per_capita DESC
    ) AS affordability_rank
FROM country_prices p
JOIN consumer_affordability a
  ON p.country = a.country
WHERE a.reference_year = 2024
ORDER BY affordability_rank;

-- 3) Compare nominal-price rank with affordability rank
WITH nominal AS (
    SELECT
        country,
        usd_equivalent,
        RANK() OVER (ORDER BY usd_equivalent DESC) AS nominal_rank
    FROM country_prices
),
aff AS (
    SELECT
        p.country,
        (p.usd_equivalent / a.consumer_ppp_per_capita) * 12 AS burden_months,
        RANK() OVER (
            ORDER BY p.usd_equivalent / a.consumer_ppp_per_capita DESC
        ) AS affordability_rank
    FROM country_prices p
    JOIN consumer_affordability a
      ON p.country = a.country
)
SELECT
    n.country,
    n.usd_equivalent,
    n.nominal_rank,
    a.burden_months,
    a.affordability_rank,
    n.nominal_rank - a.affordability_rank AS rank_shift
FROM nominal n
JOIN aff a USING (country)
ORDER BY ABS(n.nominal_rank - a.affordability_rank) DESC;

-- 4) Directional tax normalization
SELECT
    country,
    listed_price_usd,
    standard_tax_rate,
    CASE
        WHEN normalization_status IN ('NORMALIZED', 'NORMALIZED*')
        THEN listed_price_usd / (1 + standard_tax_rate)
    END AS implied_pre_tax_usd,
    normalization_status,
    caveat
FROM tax_normalization;

-- 5) India tax bridge vs US benchmark
WITH benchmark AS (
    SELECT 929.0 AS us_unlocked_list_price
),
india AS (
    SELECT
        listed_price_usd,
        standard_tax_rate,
        listed_price_usd / (1 + standard_tax_rate) AS implied_pre_tax_usd
    FROM tax_normalization
    WHERE country = 'India'
)
SELECT
    i.listed_price_usd,
    i.implied_pre_tax_usd,
    b.us_unlocked_list_price,
    (i.listed_price_usd / b.us_unlocked_list_price) - 1 AS listed_premium,
    (i.implied_pre_tax_usd / b.us_unlocked_list_price) - 1 AS tax_normalized_premium
FROM india i
CROSS JOIN benchmark b;

-- 6) India production growth
SELECT
    fiscal_year,
    production_value_usd_bn,
    production_value_usd_bn
      / LAG(production_value_usd_bn) OVER (ORDER BY fiscal_year) - 1 AS yoy_growth
FROM india_manufacturing_timeline
ORDER BY fiscal_year;

-- 7) Base-model price timeline with comparability flag
SELECT
    year,
    model,
    base_storage,
    india_price_inr,
    CASE
        WHEN base_storage = LAG(base_storage) OVER (ORDER BY year)
        THEN 'LIKE-FOR-LIKE STORAGE'
        ELSE 'STORAGE CHANGED'
    END AS storage_comparability
FROM india_price_timeline
ORDER BY year;

-- Interview-defense note:
-- Do not infer that correlation between production growth and retail price proves
-- a causal pricing relationship. Manufacturing scale, tax, FX, localization,
-- channel economics, storage, and market pricing must be analyzed separately.
