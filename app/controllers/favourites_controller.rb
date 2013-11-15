class FavouritesController < ApplicationController
  def create
    current_user.favorite_listings.create(:listing_id => params[:post_id])
  end
end
