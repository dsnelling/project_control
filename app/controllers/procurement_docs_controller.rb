# handles documents associated with requisitions.

class ProcurementDocsController < ApplicationController
  before_filter :find_requisition
  before_filter :check_authentication, :check_authorisation

  def index
    @procurement_docs = @requisition.procurement_docs.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @procurement_docs }
    end
  end

  def show
    @procurement_doc = ProcurementDoc.find(params[:id])
	user = User.find(session[:user_id])
	@view_costs = user.has_right?("View Costs")
	@view_doc = user.has_right?("Procurement_docs Show")

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @procurement_doc }
    end
  end

  def new
    @procurement_doc = ProcurementDoc.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @procurement_doc }
    end
  end

  def edit
    @procurement_doc = @requisition.procurement_docs.find(params[:id])
  end

  def create
    @procurement_doc = ProcurementDoc.new(params[:procurement_doc])
	@procurement_doc.update_by = session[:username]

    respond_to do |format|
      if @requisition.procurement_docs << @procurement_doc
        flash[:notice] = t('flash.proc_doc_create')
        format.html { redirect_to requisition_url(@requisition) }
        format.xml  { render :xml => @procurement_doc, :status => :created,
		  :location => @procurement_doc }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @procurement_doc.errors,
		  :status => :unprocessable_entity }
      end
    end
  end

  def update
    @procurement_doc = ProcurementDoc.find(params[:id])
	@procurement_doc.update_by = session[:username]
	
    respond_to do |format|
      if @procurement_doc.update_attributes(params[:procurement_doc])
        flash[:notice] = t('flash.proc_doc_create')
        format.html { redirect_to requisition_procurement_doc_url(@requisition,@procurement_doc) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @procurement_doc.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    procurement_doc = ProcurementDoc.find(params[:id])
	procurement_doc.remove_proc_document!
    @requisition.procurement_docs.delete(procurement_doc)

    respond_to do |format|
      format.html { redirect_to requisition_url(@requisition) }
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
