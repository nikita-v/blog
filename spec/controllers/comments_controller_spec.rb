require 'spec_helper'

describe CommentsController do
  context "user" do
    login_user

    describe "create action" do
      before :each do
        @attributes = FactoryGirl.attributes_for :comment
        @comment = FactoryGirl.build_stubbed :comment
        @comment.stub :save
        Comment.stub(:new).and_return @comment
      end

      it "should save comment" do
        post :create, post_id: 1, comment: @attributes
        @comment.should have_received :save
      end
    end
  end

  context "admin" do
    login_admin

    describe "destroy action" do
      before :each do
        @comment = FactoryGirl.build_stubbed :comment
        @comment.stub(:destroy)
        Comment.stub(:find).and_return @comment
        controller.stub_chain(:current_user, :can_delete?).and_return true
      end

      it "should destroy comment" do
        delete :destroy, post_id: 1, id: @comment.id
        @comment.should have_received :destroy
      end
    end
  end
end
