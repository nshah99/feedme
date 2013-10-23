class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    #puts params
    
    if @review.save
      flash[:success] = "Great Success"
      redirect_to @review
    else
      render 'new'
    end

  end

  def new
    @review = Review.new
  end

  def index
    @review = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def update
  end

  def delete
  end
  
  def review_params
    params.require(:review).permit(:listing_id, :order_id,:user_id, :review_text)
  end
end
