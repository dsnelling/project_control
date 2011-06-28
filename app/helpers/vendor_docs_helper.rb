module VendorDocsHelper

def display_status(code)
    d = VendorDoc::STATUS_TYPES.detect{|descrip, c| c ==
	  code}
	# if the code is not in the array, return the code
	d ? d.first : code
  end

  def display_icon(url)
    #selects the correct icon to display based on the file type of the url
	ext=url.split('.').last if url
    case ext
	  when "pdf" then image_tag("pdficon_large.gif")
	  when "xls", "xlsx" then image_tag("xlsicon_large.png")
	  when "jpg" then image_tag("jpgicon_large.png")
	  when "doc", "docx" then image_tag("docicon_large.png")
	  else
	    image_tag("attachment.gif")
	end
  end


end
