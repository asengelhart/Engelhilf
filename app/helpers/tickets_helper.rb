module TicketsHelper
  def user_field(form, user_id, display_user_list)
    if display_user_list
      form.collection_select :user_id, User.all, :id, :email
    else
      form.hidden_field :user_id, value: user_id
    end
  end

  def ticket_filter_path
    if params[:user_id]
      user_tickets_path(params[:user_id])
    else
      tickets_path
    end
  end
end
