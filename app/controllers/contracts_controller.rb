class ContractsController < ApplicationController
  before_filter :find_requisition

  # GET /contracts
  # GET /contracts.xml
  def index
    @contracts = @requisition.contracts.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contracts }
    end
  end

  # GET /contracts/1
  # GET /contracts/1.xml
  def show
    @contract = Contract.find(params[:id])
	user = User.find(session[:user_id])
	@view_costs = user.has_right?("View Costs")

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contract }
    end
  end

  # GET /contracts/new
  # GET /contracts/new.xml
  def new
    @contract = Contract.new
	@contract.commodity = params[:commodity]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contract }
    end
  end

  # GET /contracts/1/edit
  def edit
    @contract = @requisition.contracts.find(params[:id])
  end

  # POST /contracts
  # POST /contracts.xml
  def create
    @contract = Contract.new(params[:contract])
    @contract.update_by = session[:username]


    respond_to do |format|
      if @requisition.contracts << @contract
        flash[:notice] = t 'flash.contr_create'
        format.html { redirect_to requisition_url(@requisition) }
        format.xml  { render :xml => @contract, :status => :created, :location => @contract }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contract.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contracts/1
  # PUT /contracts/1.xml
  def update
    @contract = @requisition.contracts.find(params[:id])
    @contract.update_by = session[:username]

    respond_to do |format|
      if @contract.update_attributes(params[:contract])
        flash[:notice] = t 'flash.contr_update'
        format.html { redirect_to requisition_contract_url(@requisition,
		   @contract) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contract.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.xml
  def destroy
    contract = @requisition.contracts.find(params[:id])
    @requisition.contracts.delete(contract)

    respond_to do |format|
      format.html { redirect_to(requisition_url(@requisition)) }
      format.xml  { head :ok }
    end
  end

private
  def find_requisition
    @requisition_id = params[:requisition_id]
	return redirect_to(requisition_url) unless @requisition_id
	@requisition = Requisition.find(@requisition_id)
  end


end
