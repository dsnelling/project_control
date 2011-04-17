# provides listing and update of service requests
#
require "will_paginate"
#
class ServiceRequestsController < ApplicationController

  # must be logged in to access this controller
  before_filter :check_authentication, :check_authorisation

  # GET /service_requests
  # GET /service_requests.xml
  def index
    @service_requests = ServiceRequest.by_project(params[:proj_filter]).
	  paginate :page => params[:page],
	  :order => "project, request_ref"
	@projects = [""] + Project.find(:all).map {|p| p.name }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @service_requests }
    end
  end

  # GET /service_requests/1
  # GET /service_requests/1.xml
  def show
    @service_request = ServiceRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @service_request }
    end
  end

  # GET /service_requests/new
  # GET /service_requests/new.xml
  def new
    @service_request = ServiceRequest.new
	@projects = Project.find(:all).map {|p| p.name }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @service_request }
    end
  end

  # GET /service_requests/1/edit
  def edit
    @service_request = ServiceRequest.find(params[:id])
	@projects = Project.find(:all).map {|p| p.name }
  end

  # POST /service_requests
  # POST /service_requests.xml
  def create
    @service_request = ServiceRequest.new(params[:service_request])

    respond_to do |format|
	  @service_request.auth_date = nil if !(@service_request.status.upcase ==
	    "APPROVED") 
      if @service_request.save
        flash[:notice] = 'ServiceRequest was successfully created.'
        format.html { redirect_to(@service_request) }
        format.xml  { render :xml => @service_request, :status => :created, :location => @service_request }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @service_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /service_requests/1
  # PUT /service_requests/1.xml
  def update
    @service_request = ServiceRequest.find(params[:id])

    respond_to do |format|
      if @service_request.update_attributes(params[:service_request])
	    # no approved date unless service request status is "approved"
		#    - perhaps this should go in the model
		if !(@service_request.status.upcase == "APPROVED") 
	      @service_request.auth_date = nil
        end
		if @service_request.save
          flash[:notice] = 'ServiceRequest was successfully updated.'
          format.html { redirect_to(@service_request) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @service_request.errors, :status => :unprocessable_entity }
        end
	  end
    end
  end

  # DELETE /service_requests/1
  # DELETE /service_requests/1.xml
  def destroy
    @service_request = ServiceRequest.find(params[:id])
    @service_request.destroy

    respond_to do |format|
      format.html { redirect_to(service_requests_url) }
      format.xml  { head :ok }
    end
  end
end
