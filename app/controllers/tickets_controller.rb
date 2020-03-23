class TicketsController < ApplicationController
  def show
    @ticket = Ticket.find_by(id: params[:id])
    @comment = @ticket.comments.build
  end

  def index
    return redirect_to(user_path(params[:user_id])) if params[:user_id]
    admin_only
    @tickets = Ticket.all
    if params[:urgency_levels] && !params[:urgency_levels].blank?
      @tickets = @tickets.by_urgency_level(params[:urgency_levels])
    end
    if params[:open_or_closed]
      if params[:open_or_closed] == "open"
        @tickets = @tickets.open_tickets
      elsif params[:open_or_closed] == "closed"
        @tickets = @tickets.closed_tickets
      end
    end

    @urgency_levels = Ticket.urgency_levels
    @open_closed_options = ["open", "closed", "both"]
    render :index
  end

  def new
    @ticket = Ticket.new
    @display_user_list = false
    if params[:user_id]
      @user_id = params[:user_id]
    else
      @user_id = logged_in_user.id
      if logged_in_user.is_admin?
        @display_user_list = true
      end
    end
  end

  def edit
    @ticket = Ticket.find_by(id: params[:id])
    @user_id = @ticket.user_id
  end

  def create
    @ticket = Ticket.new(ticket_params)
    validate_ticket(@ticket) do
      render :new
    end
  end

  def update
    @ticket = Ticket.find_by(id: params[:id])
    return show_error("Ticket not found.") if ticket.nil?

    @ticket.update(ticket_params)
    validate_ticket(@ticket) do
      render :edit
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(
      :subject,
      :content,
      :urgency,
      :user_id,
      :closed,
      comments_attributes: [
        :content,
        :user_id
      ])
  end

  def validate_ticket(ticket)
    if ticket.valid?
      ticket.save
      redirect_to ticket_path(ticket)
    else
      flash[:alert] = ticket.errors.full_messages
      yield
    end
  end
end
