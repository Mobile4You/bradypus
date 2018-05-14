== form(action: "/products/#{job.product_id}/jobs/#{job.id}", method: job.id ? :patch : :post) do
  == csrf_tag
  div.form-group
    == text_field(name: "name", value: job.name, placeholder: "Name", class: "form-control")
    == text_field(name: "datacenters", value: job.datacenters, placeholder: "Datacenters", class: "form-control")
    == text_field(name: "job_type", value: job.job_type, placeholder: "Type", class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-xs")
  == link_to("back", "/products/#{job.product_id}/jobs", class: "btn btn-default btn-xs")
