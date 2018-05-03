- if @errors
  ul.errors
    - @errors.each do |error|
      li = error

== form(action: "/products/#{product.id.to_s}", method: product.id ? :patch : :post) do
  == csrf_tag
  div.form-group
    == text_field(name: "name", value: product.name, placeholder: "Name", class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-xs")
  == link_to("back", "/products", class: "btn btn-default btn-xs")
