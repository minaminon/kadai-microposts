class UsersController < ApplicationController
  before_action :require_user_logged_in,only: [:index, :show,:following,:followers]
  
  def index
    @users=User.all.page(params[:page])
  end

  def show
    @user=User.find(params[:id])
    @microposts=@user.microposts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    
    if @user.save
      flash[:success]='ユーザを登録しました'
      redirect_to @user
    else
      flash.now[:danger]='ユーザの登録に失敗しました'
      render :new
    end
  
  end
  
  def followings
    @user=User.find(params[:id])
    @followings=@user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user=User.find(params[:id])
    @followers=@user.followers.page(params[:page])
    counts(@user)
  end
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  
  def favorites
    @user=User.find(params[:id])
    #@microposts=Micropost.joins(:favorites).where(user_id: @user.id)
    #favs=@user.favorites.joins(:micropost)
    #@microposts=Micropost.joins(@user.favorites)
    #@microposts=Micropost.eager_load(:favorites)
    favs=@user.favorites.pluck(:micropost_id)
    @microposts=Micropost.where(id: favs)
    
    counts(@user)
    
  end
  
  def likes
    @user=current_user
    favs=@user.favorites.pluck(:micropost_id)
    @microposts=Micropost.where(id: favs)
  end
  
end