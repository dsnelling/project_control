module RequisitionsHelper

  # format the requisition status to display the full text
  def display_req_status(status_code)
    d = Requisition::STATUS_TYPES.detect{|descrip, code| code ==
	  status_code}
	# if the code is not in the array, return the code
	d ? d.first : status_code
  end

  def display_req_scope(scope_code)
    d = Requisition::SCOPE_TYPES.detect{|descript, code| code ==
	  scope_code}
	d ? d.first : scope_code
  end

end
