
pdf.text "Requisitons Report", :size => 24, :style => :bold

items = @requisitions.map do |req|
  [
    req.req_num,
	req.commodity,
	display_req_scope(req.scope),
	display_req_status(req.status),
	req.required_on_site,
	req.tbt_issued,
	req.cbt_issued
  ]
end

pdf.table items



