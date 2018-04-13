class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  def create
    fpost=Micropost.find(params[:micropost_id])
    current_user.fav(fpost)
    flash[:success]='お気に入りに追加しました'
    redirect_to root_url
  end

  def destroy
    fpost=Micropost.find(params[:micropost_id])
    current_user.unfav(fpost)
    flash[:success]='お気に入りを解除しました'
    redirect_to root_url
  end
end
