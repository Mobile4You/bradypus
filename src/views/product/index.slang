div.row
  div.col-sm-11
    h2 Products
  div.col-sm-1
    a.btn.btn-success.btn-xs href="/products/new" New
div.table-responsive
  table.table.table-striped
    thead
      tr
        th Name
        th Actions
    tbody
      - products.each do |product|
        tr
          td = product.name
          td
            span 
              == link_to("jobs", "/products/#{product.id}/jobs", class: "btn btn-success btn-xs")
              == link_to("versions", "/products/#{product.id}/versions", class: "btn btn-success btn-xs")
              == link_to("read", "/products/#{product.id}", class: "btn btn-success btn-xs")
              == link_to("edit", "/products/#{product.id}/edit", class: "btn btn-success btn-xs")
              == link_to("delete", "/products/#{ product.id }?_method=delete&_csrf=#{csrf_token}", class: "btn btn-danger btn-xs", onclick: "return confirm('Are you sure?');")
