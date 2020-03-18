require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create!(username: "Jim", email: "jim@example.com", password: "password")
    @invalid_user1 = User.new(email: "jim@example.com", password: "password")
    @invalid_user2 = User.new(username: "Jim", password: "password")
    @invalid_user3 = User.new(username: "Jim", email: "jim@example.com")

    @ticket1 = Ticket.create!(subject: "subject1", content: "content1", user: @user)
    @ticket2 = Ticket.create!(subject: "subject2", content: "content2", user: @user)

    @comment1 = Comment.create!(content: "content1", ticket: @ticket1, user: @user)
    @comment2 = Comment.create!(content: "content2", ticket: @ticket1, user: @user)
  end

  it "has username, password and email" do
    expect(@user).to be_valid
    expect(@user.username).to eq("Jim")
    expect(@user.email).to eq("jim@example.com")
    expect(@user.authenticate("password")).to be_truthy
    expect(@user.is_admin).to eq(false)
  end

  it "is invalid without a username, password, or email" do
    expect(@invalid_user1).not_to be_valid
    expect(@invalid_user2).not_to be_valid
    expect(@invalid_user3).not_to be_valid
  end

  it "has many tickets" do
    expect(@user.tickets).to include(@ticket1, @ticket2)
  end

  it "has many comments and commented tickets" do
    expect(@user.comments).to include(@comment1, @comment2)
    expect(@user.commented_tickets).to include(@ticket1)
    expect(@user.commented_tickets).not_to include(@ticket2)
  end
end
