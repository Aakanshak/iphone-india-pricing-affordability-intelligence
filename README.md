# Made in India. Priced for India?

### An analytics case study on iPhone pricing, affordability, manufacturing and total cost of ownership in India

India has become one of Apple's most important iPhone manufacturing hubs. I initially wanted to answer a simple question:

> **If more iPhones are being made in India, why don't they feel cheaper in India?**

The data changed the question.

India was **not** among the most expensive markets in my selected 13-country price sample. The more interesting story was **affordability**: the same phone can represent a much larger economic burden for an Indian consumer even when its nominal USD price is not globally extreme.

This project separates six different layers that are often mixed together:

**pricing · taxes · purchasing power · manufacturing scale · localization · ownership economics**

---

## Executive summary

| Finding | Result |
|---|---:|
| India iPhone 17 256GB listed price | **₹99,900** |
| USD-equivalent price | **~$1,047** |
| India nominal price rank | **7 / 13 selected markets** |
| India premium vs US listed price | **~12.7%** |
| India consumer-affordability burden | **~14.9%** of annual household-consumption PPP |
| US consumer-affordability burden | **~1.6%** |
| India / US affordability burden | **~9.3×** |
| FY26 India iPhone production value | **~$26B** |
| FY26 export share | **~83%** |
| Apple India value addition | **~14.5% average estimate** |
| Modeled iPhone monthly TCO | **₹1,665** |
| Modeled Galaxy S26 monthly TCO | **₹1,467** |

---

## The six insights

### 1. India is not the world's most expensive iPhone market

Within the selected 13-market iPhone 17 256GB snapshot, India ranks **7th by USD-equivalent listed price**.

That immediately invalidated my original framing.

**Analyst lesson:** do not force the data to support the hypothesis you started with.

---

### 2. Affordability is the stronger India story

Instead of only converting currencies, I compared the phone price with a **household-consumption PPP per-capita proxy**.

In the comparable four-market core sample:

| Market | Price burden | Consumption-equivalent months |
|---|---:|---:|
| India | ~14.9% | ~1.79 |
| China | ~9.4% | ~1.13 |
| Singapore | ~3.1% | ~0.37 |
| United States | ~1.6% | ~0.19 |

This is a macro consumer-spending proxy, **not salary or disposable income**.

**Insight:** India's challenge is less about an extreme global sticker price and more about the price relative to purchasing power.

---

### 3. Tax treatment changes the India–US comparison

India's listed price is about **12.7% above** the US unlocked Apple list price in this snapshot.

But Apple India prices include **18% GST**, while the US list price excludes state/local sales tax.

Removing GST mathematically from ₹99,900 gives an implied value around **₹84.7k / $887**.

That does **not** prove GST explains Apple's pricing. It simply demonstrates why cross-country price comparisons need tax context.

---

### 4. Manufacturing scale does not mechanically reduce retail price

Reported India iPhone production rose from **more than $7B in FY23** to around **$26B in FY26**.

At the same time, retail pricing followed a separate path.

This matters because:

> **production volume, localization and retail pricing are related — but they are not interchangeable metrics.**

---

### 5. “Made in India” does not mean “fully localized”

Reported FY26 evidence points to:

- ~**$26B** production value
- ~**$21.5B** export value
- ~**83%** export share
- ~**14.5% average** Apple India value addition estimate
- significant continued imported-component exposure

Local assembly therefore does not eliminate imported-input costs, FX exposure, taxes or pricing strategy.

---

### 6. Sticker price is not total ownership cost

I built a modeled TCO layer using:

**Purchase Price + Financing + Repairs − Resale Value**

Under identical assumptions of a 3-year hold and 40% resale:

| Device | Purchase price | Modeled monthly TCO |
|---|---:|---:|
| iPhone 17 256GB | ₹99,900 | **₹1,665** |
| Galaxy S26 256GB | ₹87,999 | **₹1,467** |

If Galaxy retains 40% after three years, the iPhone needs roughly **47.1% resale retention** for modeled monthly TCO to converge.

I intentionally use **sensitivity analysis** instead of claiming an unsupported future resale rate.

---

## Dashboard

The dashboard follows the same analytical journey:

1. **Pricing Paradox**
2. **Affordability**
3. **Made in India**
4. **Ownership Economics**

A browser-based interactive prototype is included at:

[`dashboard/dashboard.html`](dashboard/dashboard.html)

The Power BI-ready input tables and DAX measures are included in this repository.

---

## Repository structure

```text
.
├── data/               # Clean Power BI-ready CSV files
├── dashboard/          # Interactive dashboard prototype
├── docs/               # Methodology, sources and data dictionary
├── powerbi/            # DAX measures + Power BI build guide
├── python/             # Python analysis
├── research/           # Research workbook and findings
├── sql/                # SQL analysis
└── README.md
```

---

## Tools

**SQL · Python · Excel · Power BI · Research Analysis**

---

## What I would tell a stakeholder

> The original question was whether local manufacturing should make iPhones cheaper in India. The data suggests that is too simplistic. India is not unusually expensive in nominal global terms; the more meaningful issue is affordability. Manufacturing scale has increased rapidly, but local value addition, taxes, imported inputs and consumer purchasing power all tell different parts of the story.

---

## Evidence framework

To avoid mixing facts and assumptions:

| Label | Meaning |
|---|---|
| **REPORTED** | Published source |
| **CALCULATED** | Derived from reported data |
| **ESTIMATED** | External estimate / reported range |
| **MODELED** | Scenario assumption |

See [`docs/METHODOLOGY.md`](docs/METHODOLOGY.md) for limitations.

---

## Data & sources

See:

- [`docs/SOURCES.md`](docs/SOURCES.md)
- [`data/source_registry.csv`](data/source_registry.csv)
- [`research/iphone_india_pricing_research_workbook.xlsx`](research/iphone_india_pricing_research_workbook.xlsx)

---

## Key takeaway

> **“Made in India” and “affordable in India” are two different questions.**

The stronger analytical story is not that India has the world's highest iPhone price. It is that a globally ordinary premium price can still represent a much larger economic burden when viewed through local purchasing power.
