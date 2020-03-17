require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(username: "Jim", email: "jim@example.com", password: "password")
    @invalid_user1 = User.new(email: "jim@example.com", password: "password")
    @invalid_user2 = User.new(username: "Jim", password: "password")
    @invalid_user3 = User.new(username: "Jim", email: "jim@example.com")
  end

  it "has username, password and email" do
    expect(@user).to be_valid
  end

  it "is invalid without a username, password, or email" do

    expect(@invalid_user1).not_to be_valid
    expect(@invalid_user2).not_to be_valid
    expect(@invalid_user3).not_to be_valid
  end
end
