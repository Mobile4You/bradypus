-- +micrate Up
CREATE TABLE jobs (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR,
  datacenters VARCHAR,
  job_type VARCHAR,
  product_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX job_product_id_idx ON jobs (product_id);

-- +micrate Down
DROP TABLE IF EXISTS jobs;