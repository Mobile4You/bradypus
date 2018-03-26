-- +micrate Up
CREATE TABLE deployment_statuss (
  id BIGSERIAL PRIMARY KEY,
  deployment_id BIGINT,
  environment_id BIGINT,
  status VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX deployment_status_deployment_id_idx ON deployment_statuss (deployment_id);
CREATE INDEX deployment_status_environment_id_idx ON deployment_statuss (environment_id);

-- +micrate Down
DROP TABLE IF EXISTS deployment_statuss;
