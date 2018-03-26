-- +micrate Up
CREATE TABLE versions (
  id BIGSERIAL PRIMARY KEY,
  image VARCHAR,
  product_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX version_product_id_idx ON versions (product_id);

-- +micrate Down
DROP TABLE IF EXISTS versions;
