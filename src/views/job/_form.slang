== form(action: "/jobs/#{job.id.to_s}", method: job.id ? :patch : :post) do
  == csrf_tag
  div.form-group
    == text_field(name: "name", value: job.name, placeholder: "Name", class: "form-control")
    == text_field(name: "datacenters", value: job.datacenters, placeholder: "Datacenters", class: "form-control")
    == text_field(name: "type", value: job.type, placeholder: "Type", class: "form-control")
    == text_field(name: "product_id", value: job.product_id, placeholder: "Product ID", class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-xs")
  == link_to("back", "/jobs", class: "btn btn-default btn-xs")
