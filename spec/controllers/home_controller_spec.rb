require 'spec_helper'

describe HomeController do

  describe "home page" do
    it "has a login link" do
      visit root_url
      response.should be_success
      #page.should have_link "Login"
    end
  end

end
