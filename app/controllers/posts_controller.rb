class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :tag_list, only: [:create, :update]

  def index
    @posts = Post.includes(:user).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      @post.save_tags(tag_list)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @tag_list = @post.tags.pluck(:name)
    @comments = @post.comments.order('created_at DESC')
  end

  def edit
    @tag_list = @post.tags.pluck(:name).join(",")
  end

  def update
    if @post.update(post_params)
      @post.save_tags(tag_list)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def search
    if params[:text].present?
      @posts = Post.where('text LIKE ?', "%#{params[:text]}%")
    elsif params[:tag_ids].present?
      params[:tag_ids].each do |tag_id|
        if tag_id.present?
          tag = Tag.find(tag_id)
          @posts = tag.posts
        end
      end
    else
      @posts = Post.none
    end
  end

  def sort_empathy
    @posts = Post.find(Empathy.group(:post_id).order(Arel.sql('count(post_id) desc')).pluck(:post_id))
  end

  def tag_posts
    tag = Tag.find(params[:tag_id])
    @posts = tag.posts.order('created_at DESC')
  end

  private

  def post_params
    params.require(:post).permit(:text).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def tag_list
    tag_list = params[:post][:name].split(",")
  end

end
