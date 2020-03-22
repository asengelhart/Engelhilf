class CommentsController < ApplicationController
  def create
    return show_error("Comment must belong to a ticket.") unless params[:ticket_id]

    ticket = Ticket.find_by(id: params[:ticket_id])
    return show_error("Ticket not found.") if ticket.nil?
    
    comment = ticket.comments.build(comment_params)
    unless comment.save
      flash[:alert] = comment.errors.full_messages
    end
    redirect_to ticket_path(ticket)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :ticket_id, :user_id)
  end
end
