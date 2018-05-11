div.row
  div.col-sm-11
    h2 Jobs
  div.col-sm-1
    a.btn.btn-success.btn-xs href="/jobs/new" New
div.table-responsive
  table.table.table-striped
    thead
      tr
        th Name
        th Actions
    tbody
      - jobs.each do |job|
        tr
          td = job.name
          td
            span
              == link_to("versions", "/jobs/#{job.id}/versions", class: "btn btn-success btn-xs")
              == link_to("read", "/jobs/#{job.id}", class: "btn btn-success btn-xs")
              == link_to("edit", "/jobs/#{job.id}/edit", class: "btn btn-success btn-xs")
              == link_to("delete", "/jobs/#{ job.id }?_method=delete&_csrf=#{csrf_token}", class: "btn btn-danger btn-xs", onclick: "return confirm('Are you sure?');")
