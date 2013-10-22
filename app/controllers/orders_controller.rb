class OrdersController < ApplicationController
  def new
    @order = Order.new
    @listing = Listing.find(params[:listing_id])
  end

  def create
  @order = Order.new(order_params)
  @listing = Listing.find(params[:order][:listing_id])
  @order.listing_id = @listing.id
  @order.from_id = current_user.id
  @order.to_id = @listing.user_id
    if @order.save
      flash[:succes] = "Order placed successfully"
      redirect_to @order
    else 
      render 'new'
    end
  end

  def show
  end

  def index
  end

  def order_params
    params.require(:order).permit(:listing_id, :quantity, :special_request)
  end
end