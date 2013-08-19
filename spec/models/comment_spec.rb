require 'spec_helper'

describe Comment do
  let :comment do
    FactoryGirl.build :comment
  end

  it "text shouldn't be empty" do
    comment.text = ''
    comment.should_not be_valid
  end
end
