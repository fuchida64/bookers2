class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update]
    before_action :post_find, only: [:show, :edit, :update, :destroy]
    def index
        @postup = Post.new
        @posts = Post.all
        @user = User.find(current_user.id)
    end

    def create
        @posts = Post.all
        @postup = Post.new(post_params)
        @postup.user_id = current_user.id
        if @postup.save
           redirect_to post_path(@postup.id)
        else
           redirect_to posts_path
           flash[:alert] = "エラーが発生しました"
        end
    end

    def show
        @user = User.find(@post.user_id)
        @postup = Post.new
    end

    def edit
    end

    def update
        if @post.update(post_params)
              redirect_to post_path(@post.id)
        else
              render 'edit'
        end
    end

    def destroy
        @post.destroy
          redirect_to posts_path
    end
    def ensure_correct_user
        @post = Post.find_by(id: params[:id])
        if current_user.id != @post.user_id
           flash[:notice] = "権限がありません"
           redirect_to user_path(current_user.id)
        end
    end

    private
    def post_params
        params.require(:post).permit(:title, :opinion, :user_id)
    end

    def post_find
        @post = Post.find(params[:id])
    end
end