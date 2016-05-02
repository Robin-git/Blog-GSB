class PostsController < ApplicationController

  before_action :authenticate_user!, expept: [:index, :show]

  def index
    # Charge les posts,
    # trié par date de création
    # par ordre ascendant
    # @posts = Post.all.order('created_at DESC')
    @posts = Post.order('created_at DESC').page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    # Récupération du post avec l'id passé en paramétre
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(params[:post].permit(:title, :body))
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end

end
