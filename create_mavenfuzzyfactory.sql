CREATE OR REPLACE DATABASE advanced_sql_course;

CREATE OR REPLACE SCHEMA mavenfuzzyfactory;

CREATE STORAGE INTEGRATION S3_INTEGRATION
TYPE = EXTERNAL_STAGE
ENABLED = TRUE
STORAGE_ALLOWED_LOCATIONS = ('s3://<s3_bucket_name>')
  STORAGE_PROVIDER = S3
  STORAGE_AWS_ROLE_ARN = '<IAM_role_ARN>';

CREATE TABLE website_sessions (
  website_session_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL,
  user_id INT NOT NULL,
  is_repeat_session INT NOT NULL, 
  utm_source VARCHAR(12), 
  utm_campaign VARCHAR(20),
  utm_content VARCHAR(15), 
  device_type VARCHAR(15), 
  http_referer VARCHAR(30)
);

CREATE TABLE website_pageviews (
  website_pageview_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL,
  website_session_id INT NOT NULL,
  pageview_url VARCHAR(50) NOT NULL
);

CREATE TABLE products (
  product_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL,
  product_name VARCHAR(50) NOT NULL
);

CREATE TABLE orders (
  order_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL,
  website_session_id INT NOT NULL,
  user_id INT NOT NULL,
  primary_product_id INT NOT NULL,
  items_purchased INT NOT NULL,
  price_usd DECIMAL(6,2) NOT NULL,
  cogs_usd DECIMAL(6,2) NOT NULL
);

CREATE TABLE order_items (
  order_item_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  is_primary_item INT NOT NULL,
  price_usd DECIMAL(6,2) NOT NULL,
  cogs_usd DECIMAL(6,2) NOT NULL
);

CREATE TABLE order_item_refunds (
  order_item_refund_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL,
  order_item_id INT NOT NULL,
  order_id INT NOT NULL,
  refund_amount_usd DECIMAL(6,2) NOT NULL
);

COPY INTO website_sessions
FROM 
's3://<s3_bucket_name>/website_sessions.csv'
STORAGE_INTEGRATION = S3_INTEGRATION
FILE_FORMAT = ( TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY = "'")
--VALIDATION_MODE = RETURN_ERRORS
;

COPY INTO website_pageviews
FROM 
's3://<s3_bucket_name>/website_pageviews.csv'
STORAGE_INTEGRATION = S3_INTEGRATION
FILE_FORMAT = ( TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY = "'")
--VALIDATION_MODE = RETURN_ERRORS
;

COPY INTO products
FROM 
's3://<s3_bucket_name>/products.csv'
STORAGE_INTEGRATION = S3_INTEGRATION
FILE_FORMAT = ( TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY = "'")
--VALIDATION_MODE = RETURN_ERRORS
;

COPY INTO orders
FROM 
's3://<s3_bucket_name>/orders.csv'
STORAGE_INTEGRATION = S3_INTEGRATION
FILE_FORMAT = ( TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY = "'")
--VALIDATION_MODE = RETURN_ERRORS
;

COPY INTO order_items
FROM 
's3://<s3_bucket_name>/order_items.csv'
STORAGE_INTEGRATION = S3_INTEGRATION
FILE_FORMAT = ( TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY = "'")
--VALIDATION_MODE = RETURN_ERRORS
;

COPY INTO order_item_refunds
FROM 
's3://<s3_bucket_name>/order_item_refunds.csv'
STORAGE_INTEGRATION = S3_INTEGRATION
FILE_FORMAT = ( TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY = "'")
--VALIDATION_MODE = RETURN_ERRORS
;