module TicketsHelper
  def user_field(user_id, display_user_list)
    if display_user_list
      f.collection_select :user_id, User.all, :id, :email
    else
      f.hidden_field :user_id, user_id
    end
  end
end
