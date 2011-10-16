class ContractsController < ApplicationController
  before_filter :find_requisition, :only => [ :new, :create]
  before_filter :check_authentication, :check_authorisation

  # GET contracts
  def index
    @contracts = Contract.where("reference like ?",
      "#{params[:contr_filter]}%").order("reference").
      paginate(:page => params[:page])
    session[:contr_filter] = params[:contr_filter]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contracts }
    end
  end

  # GET /contracts/:id(.:format)
  def show
    @contract = Contract.find(params[:id])
	#@requisition = @contract.requisition
	user = User.find(session[:user_id])
	@view_costs = user.has_right?("View Costs")

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contract }
    end
  end

  # GET /requisition/:requisition_id/contracts/new(.:format)
  def new
	@contract = Contract.new
	@contract.commodity = params[:commodity]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contract }
    end
  end

  # GET /contracts/:id/edit(.:format)
  def edit
    @contract = Contract.find(params[:id])
  end

  # POST /requisition/:requisition_id/contracts(.:format)
  def create
    @contract = Contract.new(params[:contract])
    @contract.update_by = session[:username]


    respond_to do |format|
      if @requisition.contracts << @contract
        flash[:notice] = t 'flash.contr_create'
        format.html { redirect_to requisition_url(@requisition) }
        format.xml  { render :xml => @contract, :status => :created,
		   :location => @contract }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contract.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contracts/:id(.:format)
  def update
    @contract = Contract.find(params[:id])
    @contract.update_by = session[:username]

    respond_to do |format|
      if @contract.update_attributes(params[:contract])
        flash[:notice] = t 'flash.contr_update'
        format.html { redirect_to contract_url(@contract) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contract.errors,
		  :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/:id(.format)
  def destroy
    contract = Contract.find(params[:id])
    @requisition = contract.requisition
    @requisition.contracts.delete(contract)

    respond_to do |format|
      format.html { redirect_to(requisition_url(@requisition)) }
      format.xml  { head :ok }
    end
  end

  # show_vdocs_contract;  GET /contracts/:id/show_vdocs(.format)
  #def show_vdocs
  #  @contract = Contract.find(params[:id])
  #end

private
  def find_requisition
    requisition_id = params[:requisition_id]
	return redirect_to(requisitions_url) unless requisition_id
	@requisition = Requisition.find(requisition_id)
  end


end
