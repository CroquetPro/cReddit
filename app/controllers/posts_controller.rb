class PostsController < ApplicationController
  before_action :require_current_user!, only: [:new]
  before_action :require_author!, only: [:edit, :destroy]

  def show
    @post = Post.find(params[:id])
    if @post.url
      redirect_to @post.url
    else
      render :show
    end
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = ["Sucessfully posted #{@post.title} to #{@post.sub.title}"]
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = ["Sucessfully updated #{@post.title} from #{@post.sub.title}"]
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      @post = Post.new(post_params)
      render :edit
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = ["Sucessfully destroyed #{@post.title}. I hope you're happy."]
      redirect_to sub_url(@post.sub)
    else
      redirect_to subs_url
    end
  end

  private
  def require_author!
    if current_user.id != self.author_id
      flash[:notice] = ['Must be author to edit this post']
      redirect_to post_url(self)
    end
  end
end
