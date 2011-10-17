class ServiceReportsController < ApplicationController
  before_filter :find_service_request
  before_filter :check_authentication, :check_authorisation

  # GET /service_requests/:service_request_id/service_reports(.format)
  # def index
  # end

  # GET /service_requests/:service_request_id/service_reports/:id(.format)
  def show
    @service_report = ServiceReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @service_report }
    end
  end

  # GET /service_requests/:service_request_id/service_reports/new(.format)
  def new
    @service_report = ServiceReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @service_report }
    end
  end

  # GET /service_requests/:service_request_id/service_reports/:id/edit(.format)
  def edit
    @service_report = ServiceReport.find(params[:id])
  end

  # POST /service_requests/;service_request_id/service_reports(.format)
  def create
    @service_report = ServiceReport.new(params[:service_report])

    respond_to do |format|
      if @service_request.service_reports << @service_report
        format.html { redirect_to service_request_path(@service_report.service_request, :notice => 'Service report was successfully created.') }
        format.xml  { render :xml => @service_report, :status => :created, :location => @service_report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @service_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /service_requests/service_request:id/service_reports/:id(.format)
  def update
    @service_report = ServiceReport.find(params[:id])

    respond_to do |format|
      if @service_report.update_attributes(params[:service_report])
        format.html { redirect_to \
          service_request_path(@service_report.service_request,
            :notice => 'Service report was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @service_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /service_reports/1
  # DELETE /service_reports/1.xml
  def destroy
    service_report = ServiceReport.find(params[:id])
    @service_request = service_report.service_request
    @service_request.service_reports.destroy(service_report)

    respond_to do |format|
      format.html { redirect_to(service_request_url(@service_request)) }
      format.xml  { head :ok }
    end
  end

private
  def find_service_request
    service_request_id = params[:service_request_id]
    return redirect_to(service_request_url) unless service_request_id
    @service_request = ServiceRequest.find(service_request_id)
  end

end
