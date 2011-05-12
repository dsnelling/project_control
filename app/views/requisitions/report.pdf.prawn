# render file for the PDF report. uses prawn/prawn_to
#
# encoding: utf-8

today = Time.now
pdf.font "Times-Roman"

#pdf.text "Requisitions Report", :size => 14, :style => :bold

# manually set column widths
c_widths = [35, 130,80,100,50,50,50,50,80,80]

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
pdf.font "Times-Roman"

pdf.repeat(:all, :dynamic => true) do

#- header
  pdf.bounding_box [pdf.bounds.left, pdf.bounds.top],
    :width => pdf.bounds.width do
    pdf.text "Chengdu Air and Gas Products"
pdf.text "Requisitions and Contracts", :align => :center, :size => 16
    pdf.stroke_horizontal_rule
  end

#- footer
  pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 25 ],
      :width => pdf.bounds.width do
    pdf.stroke_horizontal_rule
    pdf.move_down(5)
    pdf.text "Page #{pdf.page_number}", :align => :center, :size => 8
    pdf.text "Printed at: #{today}", :align => :right, :size => 8
  end
end

pdf.font "#{Prawn::BASEDIR}/data/fonts/gkai00mp.ttf"
# and now the table itself
pdf.bounding_box ([pdf.bounds.left, pdf.bounds.top - 50],
  :width => pdf.bounds.width,
    :height => pdf.bounds.height - 100) do
  pdf.font_size = 8
  pdf.table (items, :header => true) do |t|
    t.column_widths = c_widths
    #t.row(0).style(:font_style => :bold, :background_color => 'cccccc')
    t.row(0).style(:background_color => 'cccccc')
  end
end

