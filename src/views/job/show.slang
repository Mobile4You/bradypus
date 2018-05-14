h1 Show Job

p | Name:
 = job.name
p | Datacenters:
 = job.datacenters
p | Job Type: 
 = job.job_type
p
  == link_to("back", "/products/#{job.product_id}/jobs", class: "btn btn-success btn-xs")
  == link_to("edit", "/products/#{job.product_id}/jobs/#{job.id}/edit", class: "btn btn-success btn-xs")
  == link_to("delete", "/products/#{job.product_id}/jobs/#{job.id}?_method=delete&_csrf=#{csrf_token}", class: "btn btn-danger btn-xs", onclick: "return confirm('Are you sure?');")
