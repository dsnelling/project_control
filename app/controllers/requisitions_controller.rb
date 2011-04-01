# RequsitionsController - allows requsitions to be managed.
# usual CRUD actions.
# comments can be added against a requisition - using comments controller
# contracts also can be added against requisitions

require "will_paginate"

class RequisitionsController < ApplicationController
# check authentication status
  before_filter :check_authentication, :check_authorisation

# GET /requisitions
  # GET /requisitions.xml
  def index
    #keep filter for next time
	session[:req_filter] = params[:req_filter] if params[:req_filter]

   #filter on start chars of req_num. filter key passed in form
    conditions = session[:req_filter] ?
	  ["project = ? AND req_num LIKE ?",session[:project],
	       session[:req_filter]+"%"] :
	  ["project = ?", session[:project] ]

   	@requisitions = Requisition.paginate :page => params[:page],
	     :conditions => conditions, :order => :req_num

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requisitions }
    end
  end

  # GET /requisitions/1
  # GET /requisitions/1.xml
  def show
    @requisition = Requisition.find(params[:id])

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
        flash[:notice] = 'Requisition was successfully created.'
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
        flash[:notice] = 'Requisition was successfully updated.'
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
