require "rails_helper"

describe "tickets", type: :feature do
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

  describe "GET show" do
    it "displays ticket" do
      log_me_in(@user.email, "password")
      visit ticket_path(@ticket1)
      expect(page).to have_content("subject1")
      expect(page).to have_content(@comment1.content)
      expect(page).to have_content(@comment2.content)
    end

    it "submits a comment from the form" do
      log_me_in(@user.email, "password")
      visit ticket_path(@ticket1)
      fill_in "ticket_comments_attributes_0_content", with: "new comment"
      click_on "Create Comment"
      expect(@ticket1.comments.last.content).to eq("new comment")
    end
  end
end