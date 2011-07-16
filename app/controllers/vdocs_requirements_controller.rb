class VdocsRequirementsController < ApplicationController
  before_filter :find_contract, :only => [:index, :new, :create]
  before_filter :check_authentication, :check_authorisation

  #layout "main_with_fancyuploader"
  #layout "main_with_plupload"

  # GET /contracts/:contract_id/vdocs_requirements(.:format)
  def index
    @vdocs_requirements = @contract.vdocs_requirements.order("code")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vdocs_requirements }
    end
  end

  # GET /vdocs_requirements/:id.(:format)
  def show
    @vdocs_requirement = VdocsRequirement.find(params[:id])
	@contract = @vdocs_requirement.contract

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vdocs_requirement }
    end
  end

  # GET /contracts/:contract_id/vdocs_requirements/new
  def new
    @vdocs_requirement = VdocsRequirement.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vdocs_requirement }
    end
  end

  # GET /vdocs_requirements/1/edit
  def edit
    @vdocs_requirement = VdocsRequirement.find(params[:id])
	@contract = @vdocs_requirement.contract

  end

  # POST /vdocs_requirements
  # POST /vdocs_requirements.xml
  def create
    @vdocs_requirement = VdocsRequirement.new(params[:vdocs_requirement])

    respond_to do |format|
      if @contract.vdocs_requirements << @vdocs_requirement
        flash[:notice] = 'VDocsRequirement was successfully created.'
        format.html { redirect_to(@vdocs_requirement) }
        format.xml  { render :xml => @vdocs_requirement, :status => :created, :location => @vdocs_requirement }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vdocs_requirement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vdocs_requirements/1
  # PUT /vdocs_requirements/1.xml
  def update
    @vdocs_requirement = VdocsRequirement.find(params[:id])
	@contract = @vdocs_requirement.contract

    respond_to do |format|
      if @vdocs_requirement.update_attributes(params[:vdocs_requirement])
        flash[:notice] = 'VdocsRequirement was successfully updated.'
        format.html { redirect_to(@vdocs_requirement) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vdocs_requirement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vdocs_requirements/1
  # DELETE /vdocs_requirements/1.xml
  def destroy
    @vdocs_requirement = VdocsRequirement.find(params[:id])
    @vdocs_requirement.destroy

    respond_to do |format|
      format.html { redirect_to(vdocs_requirements_url) }
      format.xml  { head :ok }
    end
  end

private
  def find_contract
    @contract_id = params[:contract_id]
	return redirect_to(requisition_url) unless @contract_id
	@contract = Contract.find(@contract_id)
  end

end
