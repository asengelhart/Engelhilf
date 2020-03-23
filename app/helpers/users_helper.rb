module UsersHelper
  def show_tickets(user)
    user == logged_in_user || admin_logged_in?
  end
end
