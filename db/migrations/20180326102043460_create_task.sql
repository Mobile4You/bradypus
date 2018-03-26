-- +micrate Up
CREATE TABLE tasks (
  id BIGSERIAL PRIMARY KEY,
  template VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS tasks;
