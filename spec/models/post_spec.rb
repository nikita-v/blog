require 'spec_helper'

describe Post do
  describe "testing validations" do
    let :post do
      FactoryGirl.build :post
    end

    [:title, :short_body].each do |field|
      it "#{field} shouldn't be empty" do
        post[field] = ''
        post.should_not be_valid
      end
    end
  end
end
