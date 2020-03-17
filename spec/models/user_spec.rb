require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "has username, password and email" do
    user = User.new(username: "Jim", email: "jim@example.com", password: "password")
    expect(user).to be_valid
  end
end
