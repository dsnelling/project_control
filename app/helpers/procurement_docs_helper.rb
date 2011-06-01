module ProcurementDocsHelper

  def link_to_proc_doc(url, category, view_costs, view_doc)
    #makes the link active only if the url exists and view_doc is true, and
	# if the doc is a commercial doc, will only be active if view_costs is true
	type = ProcurementDoc::CATEGORY_TYPES.detect{|name, classif, code| \
	  code == category}
	commercial_doc = type && type[1] == "C"
	permitted = view_doc && url && ( commercial_doc ? view_costs : true )
	text = permitted ? display_icon(url) : t('proc_doc.inactive')
	link_to_if(permitted, text, url)
	#"<pre> view_doc=+#{view_doc}+; view_costs=+#{view_costs}+; \
	#  permitted=+#{permitted}+</pre>"
  end

  def display_category(category_code)
    category = ProcurementDoc::CATEGORY_TYPES.detect{|desc, classif, code| \
	  code == category_code }
	category ? category.first : category_code
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
