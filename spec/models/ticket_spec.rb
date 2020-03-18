require 'rails_helper'

RSpec.describe Ticket, type: :model do
  before do
    @user = User.create!(username: "Jim", email: "jim@example.com", password: "password", is_admin: true)
    @ticket = Ticket.create!(subject: "subject", content: "content", user: @user, urgency: 0, closed_at: nil)
    @comment1 = Comment.create!(content: "content1", ticket: @ticket, user: @user)
    @comment2 = Comment.create!(content: "content2", ticket: @ticket, user: @user)
  end

  it "has subject, content and user" do
    expect(@ticket.subject).to eq("subject")
    expect(@ticket.content).to eq("content")
    expect(@ticket.user).to eq(@user)
  end

  it "must have content and user" do
    invalid_ticket1 = Ticket.new(subject: "subject", user: @user)
    invalid_ticket2 = Ticket.new(subject: "subject", content: "content")
    expect(invalid_ticket1).not_to be_valid
    expect(invalid_ticket2).not_to be_valid
  end

  it "has three levels of urgency" do
    t1 = Ticket.create!(subject: "subject", content: "content", user: @user, urgency: 0, closed_at: nil)
    t2 = Ticket.create!(subject: "subject", content: "content", user: @user, urgency: 1, closed_at: nil)
    t3 = Ticket.create!(subject: "subject", content: "content", user: @user, urgency: 2, closed_at: nil)
    t4 = Ticket.new(subject: "subject", content: "content", user: @user, urgency: 3, closed_at: nil)
    t5 = Ticket.new(subject: "subject", content: "content", user: @user, urgency: 1.3, closed_at: nil)
    expect(Ticket.only_an_annoyance).to include(t1)
    expect(Ticket.hurts_productivity).to include(t2)
    expect(Ticket.halts_work).to include(t3)
    expect(t4).not_to be_valid
    expect(t5).not_to be_valid
  end

  it "has many comments and comment_authors" do
    expect(@ticket.comments).to include(@comment1, @comment2)
    expect(@ticket.comment_authors).to include(@user)
  end

  it "is not closed if closed_at is nil" do
    expect(@ticket.closed_at).to be_nil
    expect(@ticket.closed?).to be_falsy
  end
end
