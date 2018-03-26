-- +micrate Up
CREATE TABLE group_tasks (
  id BIGSERIAL PRIMARY KEY,
  group_id BIGINT,
  task_id BIGINT,
  docker_hub_authentication_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX group_task_group_id_idx ON group_tasks (group_id);
CREATE INDEX group_task_task_id_idx ON group_tasks (task_id);
CREATE INDEX group_task_docker_hub_authentication_id_idx ON group_tasks (docker_hub_authentication_id);

-- +micrate Down
DROP TABLE IF EXISTS group_tasks;
