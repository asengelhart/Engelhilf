class CommentsController < ApplicationController
  def create
    redirect_with_error("Comment must belong to a post.") unless params[:ticket_id]
    ticket = Ticket.find_by(id: params[:ticket_id])
    redirect_with_error("Post not found.") if post.nil?
    comment = ticket.comments.build(comment_params)
    unless comment.save
      flash[:alert] = comment.errors.full_messages
    end
    redirect_to ticket_path(ticket)
  end
end
