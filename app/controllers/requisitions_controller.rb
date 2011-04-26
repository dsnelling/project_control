# RequsitionsController - allows requsitions to be managed.
# usual CRUD actions.
# comments can be added against a requisition - using comments controller
# contracts also can be added against requisitions

require "will_paginate"

class RequisitionsController < ApplicationController
# check authentication status
  before_filter :check_authentication, :check_authorisation
  prawnto :prawn => {:page_layout => :landscape}, :inline => false

  # GET /requisitions
  # GET /requisitions.xml
  # produces a tabular listing of requisitions, filtered by the applicable
  # project (stored in a session variable), and filtered.
  #
  def index
    #keep filter for next time
	session[:req_filter] = params[:req_filter] if params[:req_filter]
	session[:scope_filter] = params[:scope_filter] if params[:scope_filter]
	session[:status_filter] = params[:status_filter] if params[:status_filter]

    #uses named scopes chained together to implement filter
   	@requisitions = Requisition.by_req(session[:req_filter]).\
	  by_scope(session[:scope_filter]).by_status(session[:status_filter]).\
	  paginate(:page => params[:page],
	  :conditions => ["project = ?", session[:project] ],
	  :order => :req_num)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requisitions }
    end
  end

  def report
    @requisitions = Requisition.find(:all, :conditions => ["project = ?",
	  session[:project] ], :order => :req_num)
  end


  # GET /requisitions/1
  # GET /requisitions/1.xml
  # shows an individual requisition, with associated contracts (aka PO) and
  # comments
  def show
    @requisition = Requisition.find(params[:id])
    user = User.find(session[:user_id])
    @view_costs = user.has_right?("View Costs")

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @requisition }
    end
  end

  # GET /requisitions/new
  # GET /requisitions/new.xml
  def new
    @requisition = Requisition.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @requisition }
    end
  end

  # GET /requisitions/1/edit
  def edit
    @requisition = Requisition.find(params[:id])
  end

  # POST /requisitions
  # POST /requisitions.xml
  def create
    @requisition = Requisition.new(params[:requisition])
	# project number is set in the session variable
	@requisition.project = session[:project]
	@requisition.update_by = session[:username]

    respond_to do |format|
      if @requisition.save
        flash[:notice] = t 'flash.req_create'
        format.html { redirect_to(@requisition) }
        format.xml  { render :xml => @requisition, :status => :created, :location => @requisition }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @requisition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /requisitions/1
  # PUT /requisitions/1.xml
  def update
    @requisition = Requisition.find(params[:id])
    respond_to do |format|
      if (@requisition.update_attributes(params[:requisition]) && 
	             @requisition.update_attributes(:project => session[:project],
			         :update_by => session[:username]))
        flash[:notice] = t 'flash.req_update'
        format.html { redirect_to(@requisition) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @requisition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /requisitions/1
  # DELETE /requisitions/1.xml
  def destroy
    @requisition = Requisition.find(params[:id])
    @requisition.destroy

    respond_to do |format|
      format.html { redirect_to(requisitions_url) }
      format.xml  { head :ok }
    end
  end
end
