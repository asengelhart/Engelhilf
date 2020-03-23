class TicketsController < ApplicationController
  def show
    @ticket = Ticket.find_by(id: params[:id])
    @comment = @ticket.comments.build
    assisting_admins = @ticket.comment_authors.admins
    @assisting_admins = !assisting_admins.empty? ? assisting_admins : nil
  end

  def index
    admin_only unless params[:user_id] && params[:user_id].to_i == logged_in_user.id
    @tickets = Ticket.filter_tickets(params)
    @urgency_levels = Ticket.urgency_levels
    @open_closed_options = ["open", "closed", "both"]
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
    return show_error("Ticket not found.") if @ticket.nil?
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
