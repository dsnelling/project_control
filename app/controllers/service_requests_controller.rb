# provides listing and update of service requests
#
require "will_paginate"

class ServiceRequestsController < ApplicationController

  # must be logged in to access this controller
  before_filter :check_authentication, :check_authorisation
  layout "layouts/main", :except => :export

  # GET /service_requests
  # GET /service_requests.xml
  def index
    @service_requests = ServiceRequest.by_project(params[:proj_filter]).\
	  order("project, request_ref").paginate(:page => params[:page])
	@projects = [""] + Project.all.map {|p| p.name }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @service_requests }
    end
  end

  def report
    @service_requests = ServiceRequest.order("project, category, request_ref")
	@projects = [""] + Project.all.map {|p| p.name }

    respond_to do |format|
      format.html
      format.xml  { render :xml => @service_requests }
    end
  end
    
  def export
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="excel-export.xls"'
    headers['Cache-Control'] = ''
    @service_requests = ServiceRequest.order("project, request_ref")
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
	@projects = Project.all.map {|p| p.name }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @service_request }
    end
  end

  # GET /service_requests/1/edit
  def edit
    @service_request = ServiceRequest.find(params[:id])
	@projects = Project.all.map {|p| p.name }
  end

  # POST /service_requests
  # POST /service_requests.xml
  def create
    @service_request = ServiceRequest.new(params[:service_request])

    respond_to do |format|
	  @service_request.auth_date = nil if !(@service_request.status.upcase ==
	    "APPROVED") 
      if @service_request.save
        flash[:notice] = t('flash.sr_create')
        format.html { redirect_to(@service_request) }
        format.xml  { render :xml => @service_request, :status => :created, :location => @service_request }
      else
	    @projects = Project.all.map {|p| p.name }
        format.html { render :action => "new" }
        format.xml  { render :xml => @service_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /service_requests/1
  # PUT /service_requests/1.xml
  def update
    @service_request = ServiceRequest.find(params[:id])
    if !(@service_request.status.upcase == "APPROVED") 
	  # no approved date unless service request status is "approved"
      @service_request.auth_date = nil
    end

    respond_to do |format|
      if @service_request.update_attributes(params[:service_request])
		  flash[:notice] = t('flash.sr_update')
          format.html { redirect_to(@service_request) }
          format.xml  { head :ok }
      else
          @projects = Project.all.map {|p| p.name }
          format.html { render :action => "edit" }
          format.xml  { render :xml => @service_request.errors, :status => :unprocessable_entity }
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
