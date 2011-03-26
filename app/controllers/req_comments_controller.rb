class ReqCommentsController < ApplicationController

  before_filter :find_requisition

  def new
    @req_comment = ReqComment.new
  end

  def edit
    @req_comment = @requisition.req_comments.find(params[:id])
  end

  def create
    @req_comment = ReqComment.new(params[:req_comment])
	@req_comment.comment_by = session[:username]
	if (@requisition.req_comments << @req_comment)
	  redirect_to requisition_url(@requisition)
	else
	  render :action => :new
	end
  end

  def update
    @req_comment = @requisition.req_comments.find(params[:id])
	@req_comment.comment_by = session[:username]
	if @req_comment.update_attributes(params[:req_comment])
	  redirect_to requisition_url(@requisition)
	else
	  render :action => :edit
    end
  end

  def destroy
    comment = @requisition.req_comments.find(params[:id])
	@requisition.req_comments.delete(comment)
	redirect_to requisition_url(@requisition)
  end

private
  def find_requisition
    @requisition_id = params[:requisition_id]
	return(redirect_to(requisitions_url)) unless @requisition_id
	@requisition = Requisition.find(@requisition_id)
  end

    
end
