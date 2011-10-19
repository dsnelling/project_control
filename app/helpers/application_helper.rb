module ApplicationHelper

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

  def number_to_rmb(number)
   #formats number as RMB
    number_to_currency(number, :unit => '元', :precision=> 0, :format => '%n%u')
  end

end
