-- +micrate Up
CREATE TABLE groups (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR,
  ephemeral_disk_size VARCHAR,
  count INT,
  update_canary INT,
  update_max_parallel INT,
  update_health_check VARCHAR,
  update_min_healthy_time VARCHAR,
  update_healthy_deadline VARCHAR,
  update_auto_revert BOOL,
  job_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX group_job_id_idx ON groups (job_id);

-- +micrate Down
DROP TABLE IF EXISTS groups;
