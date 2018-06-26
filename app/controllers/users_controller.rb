class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user, only: [:edit, :update]
	before_action :user_find, only: [:show, :edit, :update]
	def show
	  	@postup = Post.new
	end

	def edit
	end

	def index
		@users = User.all
		@user = User.find(current_user.id)
		@postup = Post.new
	end

	def update
	    @user.update(user_params)
	    redirect_to user_path(@user.id)
	end

	def ensure_correct_user
        @user = User.find_by(id: params[:id])
        if current_user != @user
           flash[:notice] = "権限がありません"
           redirect_to user_path(current_user.id)
        end
    end

	private
	def user_params
	    params.require(:user).permit(:username, :profile_image, :introduction)
	end
	def user_find
        @user = User.find(params[:id])
    end
end