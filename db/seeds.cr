require "../config/*"
require "../src/models/*"

##################
# Model Example  #
##################

Task.all.each { |task| task.destroy }
Environment.all.each { |environment| environment.destroy }
TaskVariable.all.each { |task_variable| task_variable.destroy }
DockerHubAuthentication.all.each { |dha| dha.destroy } 
Group.all.each { |group| group.destroy }
GroupTask.all.each { |group_task| group_task.destroy }
Job.all.each { |job| job.destroy }
Version.all.each { |version| version.destroy }
Deployment.all.each { |deployment| deployment.destroy }
DeploymentStatus.all.each { |ds| ds.destroy }
Product.all.each { |product| product.destroy }

customer = Product.new(name: "customer")
product = Product.new(name: "product")

customer.save
product.save

customer_v1 = Version.new(image: "1-xxx", product_id: customer.id)
customer_v2 = Version.new(image: "2-yyy", product_id: customer.id)
customer_v3 = Version.new(image: "3-zzz", product_id: customer.id)
product_v10 = Version.new(image: "10-xxx", product_id: product.id)

customer_v1.save
customer_v2.save
customer_v3.save
product_v10.save

customer_api_job = Job.new(name: "customer-api-job", datacenters: "dc1", job_type: "SERVICE", product_id: customer.id)
customer_worker_job = Job.new(name: "customer-worker-job", datacenters: "dc1", job_type: "SERVICE", product_id: customer.id)
product_api_job = Job.new(name: "product-api-job", datacenters: "dc1", job_type: "SERVICE", product_id: product.id)

customer_api_job.save
customer_worker_job.save
product_api_job.save

customer_api_canary_group = Group.new(name: "customer-api-canary-group", ephemeral_disk_size: 1400, count: 2, update_canary: 1, update_max_parallel: 1, update_health_check: "checks", update_min_healthy_time: "45s", update_healthy_deadline: "2m", update_auto_revert: false, job_id: customer_api_job.id)
customer_worker_bg_group = Group.new(name: "customer-worker-bg-group", ephemeral_disk_size: 1200, count: 1, job_id: customer_worker_job.id)
product_api_canary_group = Group.new(name: "product-api-canary-group", ephemeral_disk_size: 800, count: 4,  update_canary: 1, update_max_parallel: 1, update_health_check: "checks", update_min_healthy_time: "120s", update_healthy_deadline: "2m", update_auto_revert: false, job_id: product_api_job.id)

customer_api_canary_group.save
customer_worker_bg_group.save
product_api_canary_group.save

authentication = DockerHubAuthentication.new(username: "username", password: "password")

authentication.save

customer_worker_template = "{
    \"Name\": \"customer-workers\",
    \"Driver\": \"docker\",
    \"Services\": [{
        \"name\": \"customer-workers\"
    }],
    \"Resources\": {
        \"CPU\": 239,
        \"MemoryMB\": ${RESOURCE_MEMORYMB},
        \"Networks\": [
            {
                \"MBits\": 10
            }
        ]
    },
    \"Env\": {
        \"RAILS_ENV\": \"${RAILS_ENV}\",
        \"DATABASE_SCHEMA\": \"${DATABASE_SCHEMA}\",
        \"DATABASE_USER\": \"${DATABASE_USER}\",
        \"DATABASE_PASSWORD\": \"${DATABASE_PASSWORD}\",
        \"DATABASE_HOST\": \"${DATABASE_HOST}\",
        \"SERVICE_MODEL\": \"workers\"
    }
}"

customer_api_template = "{
    \"Name\": \"customer-api\",
    \"Driver\": \"docker\",
    \"Services\": [{
        \"name\": \"customer-api\"
    }],
    \"Config\": {
        \"port_map\": [{
            \"db\": 8080
        }]
    },
    \"Resources\": {
        \"CPU\": 239,
        \"MemoryMB\": ${RESOURCE_MEMORYMB},
        \"Networks\": [
            {
                \"MBits\": 10,
                \"ReservedPorts\": [
                    {
                        \"Label\": \"db\",
                        \"Value\": 8080
                    }
                ]
            }
        ]
    },
    \"Env\": {
        \"RAILS_ENV\": \"${RAILS_ENV}\",
        \"DATABASE_SCHEMA\": \"${DATABASE_SCHEMA}\",
        \"DATABASE_USER\": \"${DATABASE_USER}\",
        \"DATABASE_PASSWORD\": \"${DATABASE_PASSWORD}\",
        \"DATABASE_HOST\": \"${DATABASE_HOST}\",
        \"SERVICE_MODEL\": \"api\"
    }
}"

customer_api_template_v2 = "{
    \"Name\": \"customer-api\",
    \"Driver\": \"docker\",
    \"Services\": [{
        \"name\": \"customer-api\"
    }],
    \"Config\": {
        \"port_map\": [{
            \"db\": 8080
        }]
    },
    \"Resources\": {
        \"CPU\": 239,
        \"MemoryMB\": ${RESOURCE_MEMORYMB},
        \"Networks\": [
            {
                \"MBits\": 10,
                \"ReservedPorts\": [
                    {
                        \"Label\": \"db\",
                        \"Value\": 8080
                    }
                ]
            }
        ]
    },
    \"Env\": {
        \"RAILS_ENV\": \"${RAILS_ENV}\",
        \"DATABASE_SCHEMA\": \"${DATABASE_SCHEMA}\",
        \"DATABASE_USER\": \"${DATABASE_USER}\",
        \"DATABASE_PASSWORD\": \"${DATABASE_PASSWORD}\",
        \"DATABASE_HOST\": \"${DATABASE_HOST}\",
        \"PRODUCT_HOST\": \"${PRODUCT_HOST}\",
        \"SERVICE_MODEL\": \"api\"
    }
}"

product_api_template = "{
    \"Name\": \"product-api\",
    \"Driver\": \"docker\",
    \"Services\": [{
        \"name\": \"product-api\"
    }],
    \"Resources\": {
        \"CPU\": 239,
        \"MemoryMB\": ${RESOURCE_MEMORYMB},
        \"Networks\": [
            {
                \"MBits\": 10
            }
        ]
    },
    \"Env\": {
        \"RAILS_ENV\": \"${RAILS_ENV}\",
        \"DATABASE_SCHEMA\": \"${DATABASE_SCHEMA}\",
        \"DATABASE_USER\": \"${DATABASE_USER}\",
        \"DATABASE_PASSWORD\": \"${DATABASE_PASSWORD}\",
        \"DATABASE_HOST\": \"${DATABASE_HOST}\",
        \"SERVICE_MODEL\": \"api\"
    }
}"

task_product_api_template = Task.new(template: product_api_template)
task_customer_api_template = Task.new(template: customer_api_template)
task_customer_worker_template = Task.new(template: customer_worker_template)
task_customer_api_template_v2 = Task.new(template: customer_api_template_v2)

task_product_api_template.save
task_customer_api_template.save
task_customer_worker_template.save
task_customer_api_template_v2.save

staging = Environment.new(name: "Staging", host: "http://another_ip:4646", strategy: "AUTO")
production = Environment.new(name: "Production", host: "", strategy: "MANUAL")

staging.save
production.save

task_variables = [
    TaskVariable.new(key: "RESOURCE_MEMORYMB",  value: "512", environment_id: staging.id, task_id: task_customer_api_template.id),
    TaskVariable.new(key: "RAILS_ENV",          value: "staging", environment_id: staging.id, task_id: task_customer_api_template.id),
    TaskVariable.new(key: "DATABASE_SCHEMA",    value: "customer_staging", environment_id: staging.id, task_id: task_customer_api_template.id),
    TaskVariable.new(key: "DATABASE_USER",      value: "thunder", environment_id: staging.id, task_id: task_customer_api_template.id),
    TaskVariable.new(key: "DATABASE_PASSWORD",  value: "thunderhoo", environment_id: staging.id, task_id: task_customer_api_template.id),
    TaskVariable.new(key: "DATABASE_HOST",      value: "db_host_stg_customer", environment_id: staging.id, task_id: task_customer_api_template.id),
    
    TaskVariable.new(key: "RESOURCE_MEMORYMB",  value: "1024", environment_id: production.id, task_id: task_customer_api_template.id),
    TaskVariable.new(key: "RAILS_ENV",          value: "production", environment_id: production.id, task_id: task_customer_api_template.id),
    TaskVariable.new(key: "DATABASE_SCHEMA",    value: "customer_production", environment_id: production.id, task_id: task_customer_api_template.id),
    TaskVariable.new(key: "DATABASE_USER",      value: "thunder", environment_id: production.id, task_id: task_customer_api_template.id),
    TaskVariable.new(key: "DATABASE_PASSWORD",  value: "thunderhoo", environment_id: production.id, task_id: task_customer_api_template.id),
    TaskVariable.new(key: "DATABASE_HOST",      value: "db_host_prd_customer", environment_id: production.id, task_id: task_customer_api_template.id),

    TaskVariable.new(key: "RESOURCE_MEMORYMB",  value: "256", environment_id: staging.id, task_id: task_customer_worker_template.id),
    TaskVariable.new(key: "RAILS_ENV",          value: "staging", environment_id: staging.id, task_id: task_customer_worker_template.id),
    TaskVariable.new(key: "DATABASE_SCHEMA",    value: "customer_staging", environment_id: staging.id, task_id: task_customer_worker_template.id),
    TaskVariable.new(key: "DATABASE_USER",      value: "thunder", environment_id: staging.id, task_id: task_customer_worker_template.id),
    TaskVariable.new(key: "DATABASE_PASSWORD",  value: "thunderhoo", environment_id: staging.id, task_id: task_customer_worker_template.id),
    TaskVariable.new(key: "DATABASE_HOST",      value: "db_host_stg_customer", environment_id: staging.id, task_id: task_customer_worker_template.id),
    
    TaskVariable.new(key: "RESOURCE_MEMORYMB",  value: "512", environment_id: production.id, task_id: task_customer_worker_template.id),
    TaskVariable.new(key: "RAILS_ENV",          value: "production", environment_id: production.id, task_id: task_customer_worker_template.id),
    TaskVariable.new(key: "DATABASE_SCHEMA",    value: "customer_production", environment_id: production.id, task_id: task_customer_worker_template.id),
    TaskVariable.new(key: "DATABASE_USER",      value: "thunder", environment_id: production.id, task_id: task_customer_worker_template.id),
    TaskVariable.new(key: "DATABASE_PASSWORD",  value: "thunderhoo", environment_id: production.id, task_id: task_customer_worker_template.id),
    TaskVariable.new(key: "DATABASE_HOST",      value: "db_host_prd_customer", environment_id: production.id, task_id: task_customer_worker_template.id),

    TaskVariable.new(key: "RESOURCE_MEMORYMB",  value: "512", environment_id: staging.id, task_id: task_customer_api_template_v2.id),
    TaskVariable.new(key: "RAILS_ENV",          value: "staging", environment_id: staging.id, task_id: task_customer_api_template_v2.id),
    TaskVariable.new(key: "DATABASE_SCHEMA",    value: "customer_staging", environment_id: staging.id, task_id: task_customer_api_template_v2.id),
    TaskVariable.new(key: "DATABASE_USER",      value: "thunder", environment_id: staging.id, task_id: task_customer_api_template_v2.id),
    TaskVariable.new(key: "DATABASE_PASSWORD",  value: "thunderhoo", environment_id: staging.id, task_id: task_customer_api_template_v2.id),
    TaskVariable.new(key: "DATABASE_HOST",      value: "db_host_stg_customer", environment_id: staging.id, task_id: task_customer_api_template_v2.id),
    TaskVariable.new(key: "PRODUCT_HOST",        value: "http://product_consul...", environment_id: staging.id, task_id: task_customer_api_template_v2.id),
    
    TaskVariable.new(key: "RESOURCE_MEMORYMB",  value: "1024", environment_id: production.id, task_id: task_customer_api_template_v2.id),
    TaskVariable.new(key: "RAILS_ENV",          value: "production", environment_id: production.id, task_id: task_customer_api_template_v2.id),
    TaskVariable.new(key: "DATABASE_SCHEMA",    value: "customer_production", environment_id: production.id, task_id: task_customer_api_template_v2.id),
    TaskVariable.new(key: "DATABASE_USER",      value: "thunder", environment_id: production.id, task_id: task_customer_api_template_v2.id),
    TaskVariable.new(key: "DATABASE_PASSWORD",  value: "thunderhoo", environment_id: production.id, task_id: task_customer_api_template_v2.id),
    TaskVariable.new(key: "DATABASE_HOST",      value: "db_host_prd_customer", environment_id: production.id, task_id: task_customer_api_template_v2.id),
    TaskVariable.new(key: "PRODUCT_HOST",         value: "http://product_consul...", environment_id: production.id, task_id: task_customer_api_template_v2.id),

    TaskVariable.new(key: "RESOURCE_MEMORYMB",  value: "1024", environment_id: staging.id, task_id: task_product_api_template.id),
    TaskVariable.new(key: "RAILS_ENV",          value: "staging", environment_id: staging.id, task_id: task_product_api_template.id),
    TaskVariable.new(key: "DATABASE_SCHEMA",    value: "product_staging", environment_id: staging.id, task_id: task_product_api_template.id),
    TaskVariable.new(key: "DATABASE_USER",      value: "thunder", environment_id: staging.id, task_id: task_product_api_template.id),
    TaskVariable.new(key: "DATABASE_PASSWORD",  value: "thunderhoo", environment_id: staging.id, task_id: task_product_api_template.id),
    TaskVariable.new(key: "DATABASE_HOST",      value: "db_host_stg_customer", environment_id: staging.id, task_id: task_product_api_template.id),
    
    TaskVariable.new(key: "RESOURCE_MEMORYMB",  value: "2048", environment_id: production.id, task_id: task_product_api_template.id),
    TaskVariable.new(key: "RAILS_ENV",          value: "production", environment_id: production.id, task_id: task_product_api_template.id),
    TaskVariable.new(key: "DATABASE_SCHEMA",    value: "product_production", environment_id: production.id, task_id: task_product_api_template.id),
    TaskVariable.new(key: "DATABASE_USER",      value: "thunder", environment_id: production.id, task_id: task_product_api_template.id),
    TaskVariable.new(key: "DATABASE_PASSWORD",  value: "thunderhoo", environment_id: production.id, task_id: task_product_api_template.id),
    TaskVariable.new(key: "DATABASE_HOST",      value: "db_host_prd_customer", environment_id: production.id, task_id: task_product_api_template.id)
]

task_variables.each { |tv| tv.save  } 

customer_api_canary_template_1 = GroupTask.new(group_id: customer_api_canary_group.id, task_id: task_customer_api_template.id,       docker_hub_authentication_id: authentication.id)
customer_worker_bg_template_1 = GroupTask.new(group_id: customer_worker_bg_group.id,  task_id: task_customer_worker_template.id,     docker_hub_authentication_id: authentication.id)
customer_api_canary_template_2 = GroupTask.new(group_id: product_api_canary_group.id, task_id: task_product_api_template.id,       docker_hub_authentication_id: authentication.id)
product_api_canary_template_1 = GroupTask.new(group_id: customer_api_canary_group.id, task_id: task_customer_api_template_v2.id,    docker_hub_authentication_id: authentication.id)

customer_api_canary_template_1.save
customer_worker_bg_template_1.save
customer_api_canary_template_2.save
product_api_canary_template_1.save

customer_api_v1_deployment = Deployment.new(group_task_id: customer_api_canary_template_1.id, version_id: customer_v1.id)
customer_worker_v1_deployment = Deployment.new(group_task_id: customer_worker_bg_template_1.id, version_id: customer_v1.id)
product_api_v10_deployment = Deployment.new(group_task_id: product_api_canary_template_1.id, version_id: product_v10.id)
customer_api_v3_deployment = Deployment.new(group_task_id: customer_api_canary_template_2.id, version_id: customer_v3.id)
customer_worker_v3_deployment = Deployment.new(group_task_id: customer_worker_bg_template_1.id, version_id: customer_v3.id)

customer_api_v1_deployment.save
customer_worker_v1_deployment.save
product_api_v10_deployment.save
customer_api_v3_deployment.save
customer_worker_v3_deployment.save

statuses = [
    DeploymentStatus.new(environment_id: staging.id, deployment_id: customer_api_v1_deployment.id, status: "REQUESTED"),
    DeploymentStatus.new(environment_id: staging.id, deployment_id: customer_api_v1_deployment.id, status: "DONE"),
    DeploymentStatus.new(environment_id: production.id, deployment_id: customer_api_v1_deployment.id, status: "REQUESTED"),
    DeploymentStatus.new(environment_id: production.id, deployment_id: customer_api_v1_deployment.id, status: "PROMOTED"),
    DeploymentStatus.new(environment_id: production.id, deployment_id: customer_api_v1_deployment.id, status: "DONE"),
    
    DeploymentStatus.new(environment_id: staging.id, deployment_id: customer_worker_v1_deployment.id, status: "REQUESTED"),
    DeploymentStatus.new(environment_id: staging.id, deployment_id: customer_worker_v1_deployment.id, status: "DONE"),
    DeploymentStatus.new(environment_id: production.id, deployment_id: customer_worker_v1_deployment.id, status: "REQUESTED"),
    DeploymentStatus.new(environment_id: production.id, deployment_id: customer_worker_v1_deployment.id, status: "DONE"),
    
    DeploymentStatus.new(environment_id: staging.id, deployment_id: product_api_v10_deployment.id, status:  "REQUESTED"),
    DeploymentStatus.new(environment_id: staging.id, deployment_id: product_api_v10_deployment.id, status:  "DONE"),
    DeploymentStatus.new(environment_id: production.id, deployment_id: product_api_v10_deployment.id, status:  "REQUESTED"),
    DeploymentStatus.new(environment_id: production.id, deployment_id: product_api_v10_deployment.id, status:  "DONE"),

    DeploymentStatus.new(environment_id: staging.id, deployment_id: customer_api_v3_deployment.id, status: "REQUESTED"),
    DeploymentStatus.new(environment_id: staging.id, deployment_id: customer_api_v3_deployment.id, status: "DONE"),
    DeploymentStatus.new(environment_id: production.id, deployment_id: customer_api_v3_deployment.id, status:  "REQUESTED"),
    DeploymentStatus.new(environment_id: production.id, deployment_id: customer_api_v3_deployment.id, status: "PROMOTED"),
    DeploymentStatus.new(environment_id: production.id, deployment_id: customer_api_v3_deployment.id, status: "DONE"),
    
    DeploymentStatus.new(environment_id: staging.id, deployment_id: customer_worker_v3_deployment.id, status: "REQUESTED"),
    DeploymentStatus.new(environment_id: staging.id, deployment_id: customer_worker_v3_deployment.id, status: "DONE"),
    DeploymentStatus.new(environment_id: production.id, deployment_id: customer_worker_v3_deployment.id, status: "REQUESTED"),
    DeploymentStatus.new(environment_id: production.id, deployment_id: customer_worker_v3_deployment.id, status: "DONE")
]

statuses.each { |deployment_status| deployment_status.save }