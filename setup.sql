-- Schema + data load for E-Commerce Funnel Analysis
-- Run with: psql -d your_db -f setup.sql

CREATE TABLE IF NOT EXISTS events (
  user_id     INT,
  event_type  TEXT,
  timestamp   TIMESTAMP,
  device      TEXT,
  source      TEXT
);

CREATE TABLE IF NOT EXISTS orders (
  order_id    INT PRIMARY KEY,
  user_id     INT,
  amount      NUMERIC,
  discount    NUMERIC,
  status      TEXT,
  timestamp   TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
  product_id  INT PRIMARY KEY,
  name        TEXT,
  category    TEXT,
  price       NUMERIC
);

\copy events FROM 'data/events.csv' CSV HEADER;
\copy orders FROM 'data/orders.csv' CSV HEADER;
\copy products FROM 'data/products.csv' CSV HEADER;

CREATE INDEX IF NOT EXISTS idx_events_user ON events(user_id);
CREATE INDEX IF NOT EXISTS idx_orders_user ON orders(user_id);
