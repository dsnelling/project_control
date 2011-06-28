module VdocsRequirementsHelper

def display_purpose(code)
    d = VdocsRequirement::PURPOSE_TYPES.detect{|descrip, c| c ==
	  code}
	# if the code is not in the array, return the code
	d ? d.first : code
  end

end
