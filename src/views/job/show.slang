h1 Show Job
p = job.name
p
  == link_to("back", "/jobs", class: "btn btn-success btn-xs")
  == link_to("edit", "/jobs/#{job.id}/edit", class: "btn btn-success btn-xs")
  == link_to("delete", "/jobs/#{job.id}?_method=delete&_csrf=#{csrf_token}", class: "btn btn-danger btn-xs", onclick: "return confirm('Are you sure?');")
