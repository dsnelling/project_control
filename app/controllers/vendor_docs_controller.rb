class VendorDocsController < ApplicationController
  before_filter :find_vdocs_requirement, :only => [:index, :new, :create]
  before_filter :check_authentication, :check_authorisation

  
=begin
  # GET /vdocs_requirement/:vdoc_requirement_id/vendor_docs(.:format)
  def index
    @vendor_docs = VendorDoc.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vendor_docs }
    end
  end
=end

  # GET /vendor_docs/:id(.:format)
  def show
    @vendor_doc = VendorDoc.find(params[:id])
	@vdocs_requirement = @vendor_doc.vdocs_requirement

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vendor_doc }
    end
  end

  # GET /vdocs_requirement/:vdoc_requirement_id/vendor_docs/new(.:format)
  def new
    @vendor_doc = VendorDoc.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vendor_doc }
    end
  end

  # GET /vendor_docs/1/edit
  def edit
    @vendor_doc = VendorDoc.find(params[:id])
    @vdocs_requirement = @vendor_doc.vdocs_requirement

  end

  # POST /vendor_docs
  # POST /vendor_docs.xml
  def create
    @vendor_doc = VendorDoc.new(params[:vendor_doc])

    respond_to do |format|
      if @vdocs_requirement.vendor_docs << @vendor_doc
        flash[:notice] = 'VendorDoc was successfully created.'
        format.html { redirect_to(@vendor_doc) }
        format.xml  { render :xml => @vendor_doc, :status => :created, :location => @vendor_doc }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vendor_doc.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vendor_docs/1
  # PUT /vendor_docs/1.xml
  def update
    @vendor_doc = VendorDoc.find(params[:id])
	@vdocs_requirement = @vendor_doc.vdocs_requirement

    respond_to do |format|
      if @vendor_doc.update_attributes(params[:vendor_doc])
        flash[:notice] = 'VendorDoc was successfully updated.'
        format.html { redirect_to(@vendor_doc) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vendor_doc.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vendor_docs/1
  # DELETE /vendor_docs/1.xml
  def destroy
    @vendor_doc = VendorDoc.find(params[:id])
    @vendor_doc.destroy

    respond_to do |format|
      format.html { redirect_to(contract_vdocs_requirements_url(@vendor_doc.vdocs_requirement.contract)) }
      format.xml  { head :ok }
    end
  end

private
  def find_vdocs_requirement
    @vdocs_requirement_id = params[:vdocs_requirement_id]
	return redirect_to(requisition_url) unless @vdocs_requirement_id
	@vdocs_requirement = VdocsRequirement.find(@vdocs_requirement_id)
  end

end
