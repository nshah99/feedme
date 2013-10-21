class ListingsController < ApplicationController
  
  def search
    @grants = Grant.search params[:search]
  end

  def new
    @listing = Listing.new
  end

  def update
  end

  def index
    @listing = Listing.search(params[:search])
  end

  def show
    @listing = Listing.find(params[:id])
  end
  def delete
  end

  def create 
    @listing = Listing.new(listing_params)

    user = User.find_by(email: @listing.email)
    @listing.user_id = user.id
    if @listing.save
      flash[:succes] = "Listing published successfully"
      redirect_to @listing
    else
      render 'new'
    end
  end
  
  def listing_params
    params.require(:listing).permit(:name,:email,:item,:price,:quantity)
  end

end
