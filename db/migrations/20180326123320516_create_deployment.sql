-- +micrate Up
CREATE TABLE deployments (
  id BIGSERIAL PRIMARY KEY,
  group_task_id BIGINT,
  version_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX deployment_group_task_id_idx ON deployments (group_task_id);
CREATE INDEX deployment_version_id_idx ON deployments (version_id);

-- +micrate Down
DROP TABLE IF EXISTS deployments;
