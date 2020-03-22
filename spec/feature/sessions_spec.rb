require "rails_helper"

describe "sessions", type: :feature do
  before do
    User.destroy_all
    Ticket.destroy_all
    Comment.destroy_all
    
    @user = User.create!(username: "Jim", email: "jim@example.com", password: "password")

    @ticket1 = Ticket.create!(subject: "subject1", content: "content1", user: @user, urgency: 0)
    @ticket2 = Ticket.create!(subject: "subject2", content: "content2", user: @user, urgency: 1)

    @comment1 = Comment.create!(content: "content1", ticket: @ticket1, user: @user)
    @comment2 = Comment.create!(content: "content2", ticket: @ticket1, user: @user)
  end

  describe "new" do
    it "displays a login screen" do
      visit "/login"
      expect(page).to have_content("Password")
    end

    it "logs in a valid user" do
      visit "/login"
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: "password"
      click_button "Submit"
      expect(current_path).to eq(user_path(@user))
    end
  end
end