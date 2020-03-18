require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    User.destroy_all
    Ticket.destroy_all
    Comment.destroy_all
    
    @user = User.create!(username: "Jim", email: "jim@example.com", password: "password")

    @ticket1 = Ticket.create!(subject: "subject1", content: "content1", user: @user)
    @ticket2 = Ticket.create!(subject: "subject2", content: "content2", user: @user)

    @comment1 = Comment.create!(content: "content1", ticket: @ticket1, user: @user)
    @comment2 = Comment.create!(content: "content2", ticket: @ticket1, user: @user)
  end

  it "has content" do
    expect(@comment1.content).to eq("content1")
    invalid_comment = Comment.new(ticket: @ticekt1, user: @user)
    expect(invalid_comment).not_to be_valid
  end

  it "has a user and a ticket" do
    expect(@comment1.user).to eq(@user)
    expect(@comment1.ticket).to eq(@ticket1)
  end

  it "has timestamps" do
    expect(@comment1.created_at).to be_truthy
  end
end
