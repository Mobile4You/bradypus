-- +micrate Up
CREATE TABLE task_variables (
  id BIGSERIAL PRIMARY KEY,
  key VARCHAR,
  value VARCHAR,
  environment_id BIGINT,
  task_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX task_variable_environment_id_idx ON task_variables (environment_id);
CREATE INDEX task_variable_task_id_idx ON task_variables (task_id);

-- +micrate Down
DROP TABLE IF EXISTS task_variables;
