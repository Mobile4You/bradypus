h1 Show Product
p = product.name
p
  == link_to("back", "/products", class: "btn btn-success btn-xs")
  == link_to("edit", "/products/#{product.id}/edit", class: "btn btn-success btn-xs")
  == link_to("delete", "/products/#{product.id}?_method=delete&_csrf=#{csrf_token}", class: "btn btn-danger btn-xs", onclick: "return confirm('Are you sure?');")
