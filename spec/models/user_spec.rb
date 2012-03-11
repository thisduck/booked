require 'spec_helper'

describe User do
  let (:auth_hash) { OmniAuth.config.mock_auth[:twitter] }
  let (:auth_key) { "twitter-123545" }

  it "returns auth key given auth hash" do
    User.auth_key(auth_hash).should == auth_key
  end

  it "finds user using the auth hash" do
    user = FactoryGirl.create(:user, :auth_keys => [auth_key])
    User.find_with_auth_hash(auth_hash).should == user
  end

  context "create user using auth hash" do 
    it "creates the user" do
      expect {
        User.create_by_auth_hash(auth_hash)
      }.should change(User, :count).by 1
    end

    it "stores the user handle" do
      User.create_by_auth_hash(auth_hash).handle.should == "thisduck"
    end

    it "stores the user name" do
      User.create_by_auth_hash(auth_hash).name.should == "Adnan Ali"
    end
  end

  context "fetch user by auth hash" do
    context "user does not exist" do
      it "creates a new user if none is found" do
        expect {
          User.fetch_by_auth_hash auth_hash
        }.should change(User, :count).by 1
      end
    end
    context "user exists" do
      it "finds existing user with hash" do
        user = User.fetch_by_auth_hash auth_hash
        User.fetch_by_auth_hash(auth_hash).should == user
      end
    end
  end
end
