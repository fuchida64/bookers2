class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user, {only: [:edit, :update]}
	def show
	  	@user = User.find(params[:id])
	  	@postup = Post.new
	end

	def edit
	    @user = User.find(params[:id])
	end

	def index
		@users = User.all
		@user = User.find(current_user.id)
		@postup = Post.new
	end

	def update
	    @user = User.find(params[:id])
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
end
