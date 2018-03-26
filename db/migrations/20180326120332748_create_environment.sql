-- +micrate Up
CREATE TABLE environments (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR,
  host VARCHAR,
  strategy VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS environments;
