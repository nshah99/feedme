class OrdersController < ApplicationController
  def new
    @order = Order.new
    @listing = Listing.find(params[:listing_id])
  end

  def create
  @order = Order.new(order_params)
  @listing = Listing.find(params[:order][:listing_id])
  @order.listing_id = @listing.id
  @order.user_id = current_user.id
  @order.to_id = @listing.user_id
    if @order.save & Listing.decrement_quantity(@listing.id,@order.quantity)
      flash[:succes] = "Order placed successfully"
      redirect_to @order
    else 
      flash[:fail] = "Check quantity"
      redirect_to new_order_path(listing_id:@listing.id)
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def index
    @order = Order.all
  end

  def order_params
    params.require(:order).permit(:item,:listing_id, :quantity, :special_request)
  end
end
