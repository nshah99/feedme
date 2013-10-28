class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.ip = "98.242.64.230"
      if @user.save
        sign_in @user

        #if @user.ip == "98.242.64.230"
        #  flash[:success] = "98.242.64.230"
        #else
        #  flash[:failure]=  9999999999999999
        #end
   
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
    dow[0] = "Sun"
    dow[1] = "Mon"
    dow[2] = "Tue"
    dow[3] = "Wed"
    dow[4] = "Thur"
    dow[5] = "Fri"
    dow[6] = "Sat"
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
    
    @allListing = Listing.all
    @listings = @allListing[0..9]
    @events = Event.all.limit(10)
    @orders = Order.all.limit(10)
    id_top5 = Listing.top5
    @top5 = Listing.get_objects_by_id(id_top5)
    @feed = (@listings+@events+@orders).sort_by(&:created_at).reverse[0..9]
    if !current_user.nil?
     @reco = is_comprende(@allListing)
    end
  end
  def show
    @user = User.find(params[:id])
    @listing = @user.listings
    @review = @user.reviews
  end

  def is_comprende(listings)
    
    if !current_user.cuisines.nil?
      user_cuisines = current_user.cuisines.split(',').collect{|x| x.strip}
      suggested_listings = []
      listings.each do |f|
        if f.cuisine.in?(user_cuisines)
          suggested_listings.append(f)
        end
      end
    end
    return suggested_listings
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  
  private
  def user_params
      params.require(:user).permit(:ip,:email,:password,:name,:password_confirmation,:picture,:description,:cuisines,:address_line)
  end
end
