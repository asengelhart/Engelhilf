require "rails_helper"

describe "welcome", type: :feature do
  describe "home" do
    context "not logged in" do
      it "redirects to the login page" do
        visit "/"
        expect(page.current_path).to eq(login_path)
      end
    end
  end
end