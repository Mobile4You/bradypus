-- +micrate Up
CREATE TABLE docker_hub_authentications (
  id BIGSERIAL PRIMARY KEY,
  username VARCHAR,
  password VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS docker_hub_authentications;
