div.row
  div.col-sm-11
    h2 Versions
  div.col-sm-1
    a.btn.btn-success.btn-xs href="/products/#{ id }/versions/new" New
div.table-responsive
  table.table.table-striped
    thead
      tr
        th Name
    tbody
      - versions.each do |version|
        tr
          td = version.image
