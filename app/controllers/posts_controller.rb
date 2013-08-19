class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  authorize_actions_for Post, except: [:index, :show]
  before_action :load_post, except: [:index, :show, :new, :create]

  def index
    @posts = Post.eager_load(:user).page params[:page]
  end

  def show
    @post = Post.eager_load(:user, comments: :user).where(id: params[:id]).first
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update_attributes post_params
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def load_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :short_body, :full_body)
  end
end
