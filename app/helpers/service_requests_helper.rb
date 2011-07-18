module ServiceRequestsHelper
  def display_category(code)
    d = ServiceRequest::CATEGORY_TYPES.detect{|descript, c| c ==
	  code}
	d ? "#{code}: #{d.first}" : code
  end


end
