# mange usual CRUD actions for the site manhours records

require "will_paginate"

class SiteHoursController < ApplicationController
  before_filter :check_authentication, :check_authorisation

  # GET /site_hours
  # GET /site_hours.xml
  def index

    #only get the records for selected project
    @site_hours = SiteHour.where("project = ?", session[:project]).order("week_start DESC").\
	  paginate(:page => params[:page])
	# total hours - perhaps there's a better way to do this using enums..?
	@total_owner = SiteHour.where("project = ?", session[:project]).sum(:owner_hr)
	@total_epc = SiteHour.where("project = ?", session[:project]).sum(:epc_hr)
	@total_svision = SiteHour.where("project = ?", session[:project]).sum(:svision_hr)
	@total_constr = SiteHour.where("project = ?", session[:project]).sum(:constr_hr)
	@total_hours = SiteHour.where("project = ?", session[:project]).sum(:total_hr)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @site_hours }
    end
  end

  # GET /site_hours/1
  # GET /site_hours/1.xml
  def show
    @site_hour = SiteHour.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @site_hour }
    end
  end

  # GET /site_hours/new
  # GET /site_hours/new.xml
  def new
    @site_hour = SiteHour.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @site_hour }
    end
  end

  # GET /site_hours/1/edit
  def edit
    @site_hour = SiteHour.find(params[:id])
  end

  # POST /site_hours
  # POST /site_hours.xml
  def create
    @site_hour = SiteHour.new(params[:site_hour])
	@site_hour.project = session[:project]

    respond_to do |format|
      if @site_hour.save
        flash[:notice] = t 'flash.site_hr_create'
        format.html { redirect_to(@site_hour) }
        format.xml  { render :xml => @site_hour, :status => :created, :location => @site_hour }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @site_hour.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /site_hours/1
  # PUT /site_hours/1.xml
  def update
    @site_hour = SiteHour.find(params[:id])

    respond_to do |format|
	  @site_hour.project = session[:project]
      if @site_hour.update_attributes(params[:site_hour])
        flash[:notice] = t 'flash.site_hr_update'
        format.html { redirect_to(@site_hour) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @site_hour.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /site_hours/1
  # DELETE /site_hours/1.xml
  def destroy
    @site_hour = SiteHour.find(params[:id])
    @site_hour.destroy

    respond_to do |format|
      format.html { redirect_to(site_hours_url) }
      format.xml  { head :ok }
    end
  end
end
