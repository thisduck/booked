require 'spec_helper'

describe Entry do
  before :all do
    @valid_attributes = {
      :title => "Hello",
      :body => "there",
    }
  end
  context "create" do
    before do
      user = FactoryGirl.build_stubbed(:admin)
      user.stub(:admin?).and_return(true)
      Entry.any_instance.stub(:user).and_return(user)
    end

    it "should have a creator" do
      entry = Entry.create
      entry.errors[:user_id].should be_present
    end

    it "should have a title" do
      entry = Entry.create
      entry.errors[:title].should be_present
    end

    it "should have a body" do
      entry = Entry.create
      entry.errors[:body].should be_present
    end

    it "allows admin to create entry" do
      user = FactoryGirl.build_stubbed(:admin)
      user.stub(:admin?).and_return(true)

      entry = Entry.new(@valid_attributes.merge(:user_id => user.id))
      entry.stub(:user).and_return(user)

      entry.save.should be_true
      entry.should be_valid
    end

    it "does not allow editor or user to create entry" do
      user = FactoryGirl.build_stubbed(:user)
      user.stub(:admin?).and_return(false)

      entry = Entry.new(@valid_attributes.merge(:user_id => user.id))
      entry.stub(:user).and_return(user)

      entry.save.should be_false
      entry.errors[:user_id].should be_present
      entry.should_not be_valid
    end
  end
end
