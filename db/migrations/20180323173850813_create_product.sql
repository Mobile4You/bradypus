-- +micrate Up
CREATE TABLE products (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS products;
