# centralised storage library for project standard documents (procedures,
# forms, etc) 

require 'will_paginate'

class LibraryDocsController < ApplicationController
  before_filter :check_authentication, :check_authorisation

# GET /library_docs
  # GET /library_docs.xml
  def index
    # need to think how to order these in a sensible way
    @library_docs = LibraryDoc.order("reference, category").paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @library_docs }
    end
  end

  # GET /library_docs/1
  # GET /library_docs/1.xml
  def show
    @library_doc = LibraryDoc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @library_doc }
    end
  end

  # GET /library_docs/new
  # GET /library_docs/new.xml
  def new
    @library_doc = LibraryDoc.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @library_doc }
    end
  end

  # GET /library_docs/1/edit
  def edit
    @library_doc = LibraryDoc.find(params[:id])
  end

  # POST /library_docs
  # POST /library_docs.xml
  def create
    @library_doc = LibraryDoc.new(params[:library_doc])

    respond_to do |format|
      if @library_doc.save
        flash[:notice] = 'LibraryDoc was successfully created.'
        format.html { redirect_to(@library_doc) }
        format.xml  { render :xml => @library_doc, :status => :created, :location => @library_doc }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @library_doc.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /library_docs/1
  # PUT /library_docs/1.xml
  def update
    @library_doc = LibraryDoc.find(params[:id])

    respond_to do |format|
      if @library_doc.update_attributes(params[:library_doc])
        flash[:notice] = 'LibraryDoc was successfully updated.'
        format.html { redirect_to(@library_doc) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @library_doc.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /library_docs/1
  # DELETE /library_docs/1.xml
  def destroy
    @library_doc = LibraryDoc.find(params[:id])
    @library_doc.destroy

    respond_to do |format|
      format.html { redirect_to(library_docs_url) }
      format.xml  { head :ok }
    end
  end
end
