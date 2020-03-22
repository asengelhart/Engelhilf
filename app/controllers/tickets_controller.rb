class TicketsController < ApplicationController
  def new
    @ticket = Ticket.new
  end

  def edit
    @ticket = Ticket.find_by(id: params[:id])
    @comment = @ticket.comments.build
  end

  def show
    @ticket = Ticket.find_by(id: params[:id])
    @comment = @ticket.comments.build
  end

  def create
    ticket = Ticket.new(ticket_params)
    validate_ticket(ticket)
  end

  def update
    ticket = Ticket.find_by(id: params[:id])
    redirect_with_error("Ticket not found.") if ticket.nil?
    ticket.update(ticket_params)
    validate_ticket(ticket)
  end

  private

  def ticket_params
    params.require(:ticket).permit(:subject, :content, :urgency, :user_id, :closed)
  end

  def validate_ticket(ticket)
    if ticket.valid?
      ticket.save
      redirect_to ticket_path(@ticket)
    else
      flash[:alert] = @ticket.errors.full_messages
      render :new
    end
  end
end
