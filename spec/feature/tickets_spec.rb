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

  describe "GET new" do
    it "allows an admin to submit tickets on behalf of user" do
      log_me_in(@admin.email, "password")
      visit new_ticket_path
      select @user.email, from: "ticket_user_id"
      fill_in "ticket_subject", with: "New ticket"
      fill_in "ticket_content", with: "Ticket content"
      choose "ticket_urgency_0"
      click_on "Create Ticket"
      expect(@user.tickets.last.content).to eq("Ticket content")
    end

    it "disallows having empty fields" do
      log_me_in(@admin.email, "password")
      visit new_ticket_path
      select @user.email, from: "ticket_user_id"
      fill_in "ticket_subject", with: "New ticket"
      fill_in "ticket_content", with: "Ticket content"
      click_on "Create Ticket"
      expect(page).to have_content("Urgency can't be blank")

      visit new_ticket_path
      fill_in "ticket_subject", with: "New ticket"
      fill_in "ticket_content", with: ""
      choose "ticket_urgency_1"
      click_on "Create Ticket"
      expect(page).to have_content("Content can't be blank")
    end
  end

  describe "GET edit" do
    it "opens and closes tickets when checkbox is clicked" do
      log_me_in(@admin.email, "password")
      visit edit_ticket_path(@ticket1)
      expect(page).to have_field("ticket_closed")
      expect(page).not_to have_checked_field("ticket_closed")
      check "ticket_closed"
      click_on "Update Ticket"
      expect(page).to have_content("Closed")
    end
  end
end