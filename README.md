# E-Commerce Funnel Analysis (PostgreSQL)

SQL analysis of a simulated e-commerce funnel (5,000 users, ~8,900 events, 818 orders) to identify where users drop off and which acquisition channels convert best.

## Problem

The business wants to know: which traffic sources actually drive purchases (not just visits), where in the funnel users abandon, and whether device type affects conversion — to prioritize acquisition spend and UX fixes.

## Data

- `events.csv` — user_id, event_type (page_view → add_to_cart → checkout_start → purchase), timestamp, device, source
- `orders.csv` — order_id, user_id, amount, discount, status, timestamp
- `products.csv` — product_id, name, category, price

Loaded into PostgreSQL via `\copy`. Schema and load steps in `setup.sql`.

## Analysis (`queries.sql`)

1. **Funnel by traffic source** — view→cart, cart→checkout, and overall conversion per channel
2. **Weekly cohort conversion** — acquisition-week cohorts tracked through to purchase, to spot trend/seasonality
3. **Device drop-off** — page view → purchase conversion by device

## Key Findings

**Source performance** — Social has the highest overall conversion (18.5%), ahead of email (17.0%) and organic (16.3%). Paid ads (15.4%) and referral (14.8%) convert worst despite referral having a comparable cart-add rate — meaning the drop-off happens later in referral's funnel, not at initial interest.

| source   | viewers | overall conversion |
| -------- | ------- | ------------------ |
| social   | 761     | 18.5%              |
| email    | 698     | 17.0%              |
| organic  | 1,783   | 16.3%              |
| paid_ads | 1,251   | 15.4%              |
| referral | 507     | 14.8%              |

**Device gap is the biggest lever** — Desktop converts at 25.6%, more than double mobile's 10.5% (tablet: 12.7%), despite mobile driving the most page views (2,773 vs desktop's 1,905). Mobile checkout UX is the clearest optimization target in the dataset.

| device  | page views | purchases | conversion |
| ------- | ---------- | --------- | ---------- |
| desktop | 1,905      | 487       | 25.6%      |
| tablet  | 322        | 41        | 12.7%      |
| mobile  | 2,773      | 290       | 10.5%      |

**Cohort trend** — weekly conversion is stable in the 12–19% range across ~6 months (Jan–Jun 2026) with no strong upward or downward trend, suggesting the funnel's issues are structural (device/UX) rather than a recent regression.

Full result sets: `results/query1_funnel_by_source.csv`, `results/query2_weekly_cohorts.csv`, `results/query3_device_dropoff.csv`

## Dashboard

[Open Dashboard](https://harshal-1412.github.io/E-commerce-Funnel-Analysis/dashboard.html) — standalone visual summary (KPIs, funnel chart, device conversion, weekly cohort trend) built on the query results above. Open it directly in a browser, no server needed.

## Tools

PostgreSQL, SQL (CTEs, conditional aggregation, window-style pivoting), HTML/Chart.js for the dashboard

## How to run

```bash
psql -d your_db -f setup.sql
psql -d your_db -f queries.sql
```
