class TicketsController < ApplicationController
  def new
    @ticket = Ticket.new
  end

  def show
    @ticket = Ticket.find_by(id: params[:id])
    @comment = @ticket.comments.build
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.valid?
      @ticket.save
      redirect_to ticket_path(@ticket)
    else
      flash[:alert] = @ticket.errors.full_messages
      render :new
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:subject, :content, :urgency, :user_id, :closed)
  end
end
