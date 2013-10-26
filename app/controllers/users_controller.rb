class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to FeedMe !!"
        redirect_to @user
      else
         render 'new'
      end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def delete
  end
  def index
    @user = User.all
    dow={}
    dow[0] = "Sunday"
    dow[1] = "Monday"
    dow[2] = "Tuesday"
    dow[3] = "Wednesday"
    dow[4] = "Thursday"
    dow[5] = "Friday"
    dow[6] = "Saturday"
    @dow = dow
    moy = {}
    moy[1]="Jan"
    moy[2]="Feb"
    moy[3]="March"
    moy[4]="April"
    moy[5]="May"
    moy[6]="June"
    moy[7]="July"
    moy[8]="Aug"
    moy[9]="Sept"
    moy[10]="Oct"
    moy[11]="Nov"
    moy[12]="Dec"
    @moy = moy
    
    listings = Listing.all.limit(10)
    events = Event.all.limit(10)
    orders = Order.all.limit(10)
    @feed = (listings+events+orders).sort_by(&:created_at).reverse[0..9]
  end
  def show
    @user = User.find(params[:id])
    @listing = @user.listings
    @review = @user.reviews
  end
  
  private
  def user_params
      params.require(:user).permit(:email,:password,:name,:password_confirmation,:picture,:description,:cuisines)
  end
end
