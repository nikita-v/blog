require 'spec_helper'

describe PostsController do

  context "guest or user" do
    describe "index action" do
      before :each do
        @posts = [FactoryGirl.build_stubbed(:post), FactoryGirl.build_stubbed(:post)]
        Post.stub(:page).and_return @posts
      end

      it "should render index template" do
        get :index
        response.should render_template :index
      end

      it "should assigns @posts" do
        get :index
        expect(assigns(:posts)).to match_array @posts
      end
    end

    describe "show action" do
      before :each do
        @id = 1
        @post = FactoryGirl.build_stubbed :post
        Post.stub_chain(:eager_load, :where, :first).and_return @post
      end

      it "should render show template" do
        get :show, id: @id
        response.should render_template :show
      end

      it "should assigns @post" do
        get :show, id: @id
        expect(assigns(:post)).to be @post
      end
    end

    [:guest, :user].each do |role|
      describe "#{role}" do
        login_user if role == :user

        [:new, :create, :edit, :update, :destroy].each do |action|
          it "should access denies to #{action}" do
            params = nil
            params = {id: 1} if [:edit, :destroy].include? action
            params = {post: FactoryGirl.attributes_for(:post)} if action == :create
            params = {id: 1, post: FactoryGirl.attributes_for(:post)} if action == :update
            get action, params if [:new, :edit].include? action
            post action, params if action == :create
            patch action, params if action == :update
            delete action, params if action == :destroy
            response.response_code.should eq 403 if role == :user
            response.should redirect_to new_user_session_path if role == :guest
          end
        end
      end
    end
  end

  context "admin" do
    login_admin

    before :each do
      controller.stub_chain(:current_user, :can_create?).and_return true
      controller.stub_chain(:current_user, :can_update?).and_return true
      controller.stub_chain(:current_user, :can_delete?).and_return true
    end

    describe "new action" do
      before :each do
        @post = FactoryGirl.build_stubbed :post
        Post.stub(:new).and_return @post
      end

      it "should render new template" do
        get :new
        response.should render_template :new
      end

      it "should assigns @post" do
        get :new
        expect(assigns(:post)).to be @post
      end
    end

    describe "create action" do
      before :each do
        @attributes = FactoryGirl.attributes_for :post
        @post = Post.new
        controller.stub_chain(:current_user, :posts, :build).and_return @post
      end

      context "valid attributes" do
        before :each do
          @post.stub(:save).and_return true
          @post.stub(:can_create?).and_return true
        end

        it "should redirect to the posts page" do
          post :create, post: @attributes
          response.should redirect_to posts_path
        end
      end

      context "invalid attributes" do
        before :each do
          @post.stub(:save).and_return false
        end

        it "should render new template" do
          post :create, post: @attributes
          response.should render_template :new
        end
      end
    end

    describe "edit action" do
      before :each do
        @id = 1
        @post = FactoryGirl.build_stubbed :post
        Post.stub(:find).with(@id.to_s).and_return @post
      end

      it "should render edit template" do
        get :edit, id: @id
        response.should render_template :edit
      end

      it "should assigns @post" do
        get :edit, id: @id
        expect(assigns(:post)).to eq @post
      end
    end

    describe "update action" do
      before :each do
        @post = FactoryGirl.build_stubbed :post
        @attributes = FactoryGirl.attributes_for :post
        Post.stub(:find).with(@post.id.to_s).and_return @post
      end

      context "valid attributes" do
        before :each do
          @post.stub(:update_attributes).and_return true
        end

        it "should redirect to post page" do
          patch :update, id: @post.id, post: @attributes
          response.should redirect_to post_path(@post.id)
        end
      end

      context "invalid attributes" do
        before :each do
          @post.stub(:update_attributes).and_return false
        end

        it "should render edit template" do
          patch :update, id: @post.id, post: @attributes
          response.should render_template :edit
        end
      end
    end

    describe "destroy action" do
      before :each do
        @post = FactoryGirl.build_stubbed :post
        @post.stub(:destroy)
        Post.stub(:find).with(@post.id.to_s).and_return @post
      end

      it "should call destroy method" do
        delete :destroy, id: @post.id
        @post.should have_received :destroy
      end

      it "should redirect to the posts page" do
        delete :destroy, id: @post.id
        response.should redirect_to posts_path
      end
    end
  end
end
