require "rails_helper"

describe "users", type: :feature do
  before do
    User.destroy_all
    Ticket.destroy_all
    Comment.destroy_all

    @admin = User.create!(username: "Admin", email: "admin@example.com", password: "password", is_admin: true)
    @user = User.create!(username: "Jim", email: "jim@example.com", password: "password", is_admin: false)

    @ticket1 = Ticket.create!(subject: "subject1", content: "content1", user: @user, urgency: 0)
    @ticket2 = Ticket.create!(subject: "subject2", content: "content2", user: @user, urgency: 1)

    @comment1 = Comment.create!(content: "content1", ticket: @ticket1, user: @user)
    @comment2 = Comment.create!(content: "content2", ticket: @ticket1, user: @user)
  end

  describe "GET new" do
    it "allows a user to create an account" do
      visit new_user_path
      fill_in "user_username", with: "Bobb"
      fill_in "user_email", with: "bobb@example.com"
      fill_in "user_password", with: "password"
      click_on "Create User"
      expect(User.last.email).to eq("bobb@example.com")
    end

    it "allows an admin to create admin accounts" do
      log_me_in(@admin.email, "password")
      visit new_user_path
      fill_in "user_username", with: "Steve"
      fill_in "user_email", with: "steve@example.com"
      fill_in "user_password", with: "password"
      check "user_is_admin"
      click_on "Create User"
      expect(User.last.is_admin).to eq(true)
    end
  end

  describe "GET index" do
    it "only displays for an admin" do
      log_me_in(@user.email, "password")
      visit users_path
      expect(page).to have_content("This action requires administrative privileges.")
    end

    it "displays all users" do
      log_me_in(@admin.email, "password")
      visit users_path
      expect(page).to have_content(@user.username)
      expect(page).to have_content(@admin.email)
    end
  end
end