# render file for the PDF report. uses prawn/prawn_to
#
pdf.font "Times-Roman"

pdf.text "Requisitions Report", :size => 14, :style => :bold

# manually set column widths
c_widths = [30, 130,80,100,50,50,50,50,80,80]

#table headers
head = [
  "Ref",
  "Commodity",
  "Scope/ Contract Ref",
  "Status/ Supplier",
  "ROS/ Contract Date",
  "RDC/ Delivery Terms",
  "Bid Applic/ Delivery Date",
  "Enquiry/ Delivery Forecast",
  "TBT Issue/ Expedite Status",
  "CBT Issue/ Expeditors Comments"]

items = []
items << head

@requisitions.each do |req|
  # one row's requisition info
  items << [
    req.req_num,
	req.commodity,
	display_req_scope(req.scope),
	display_req_status(req.status),
	req.required_on_site,
	req.required_contract,
	req.bid_applic_approved,
	req.enquiry_issued,
	req.tbt_issued,
	req.cbt_issued
  ]

  # if present, list contracts assoociatied with this requisition
  unless req.contracts.empty?
    req.contracts.sort_by{|c| c.reference }.each do |contract|
	  items << [
	    " ",
		contract.commodity,
	    contract.reference,
	    contract.supplier,
		contract.commence_date,
		contract.delivery_terms,
		contract.delivery_date_contract,
		contract.delivery_date_forecast,
		contract.expedite_status,
		truncate(contract.expedite_comment, :length => 30)
	    ]
	  end
    end
  end

#now write the table out
pdf.font_size 8
pdf.table (items, :header => true) do |t|
  t.column_widths = c_widths
end

pdf.number_pages "<page> of <total>",{:at => [pdf.bounds.right - 50, 0] }


