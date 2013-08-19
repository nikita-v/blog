require 'spec_helper'

describe User do
  describe "testing validations" do
    let :user do
      FactoryGirl.build :user
    end

    it "name shouldn't be empty" do
      user.name = ''
      user.should_not be_valid
    end

    it "name should be unique" do
      user.save
      new_user = FactoryGirl.build(:user, email: 'alice@example.com')
      new_user.should_not be_valid
    end

    it "role should be only 'user' or 'admin'" do
      user.role = 'my_role'
      user.should_not be_valid
    end
  end
end
