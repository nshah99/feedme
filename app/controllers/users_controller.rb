class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def surprise
    @user = User.find(params[:id])
    subscribing = @user.followed_users
    
    #user_cuisines = @user.cuisines
    all_current_listings = Listing.search("")
    
    positive_listings = []
    user_rated_positive_listings = []

    past_orders = @user.orders
    past_chefs=[]
    past_orders.each {|x| past_chefs.append(x.listing.user)}
    past_listings = []
    k=""
    past_orders.each do |x| 
      past_listings.append(x.listing)
      k+=" "+x.listing.item
    end
    freq = past_chefs.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    frequent_chef = past_chefs.sort_by { |v| freq[v] }.last
    reco_most_freq_chef_curr_listing=nil
    all_current_listings.each do |x|
      if !frequent_chef.nil? && x.user.id == frequent_chef.id
        reco_most_freq_chef_curr_listing = x
      end
    end
    
    if !reco_most_freq_chef_curr_listing.in? past_listings
      @reco_most_freq_chef_curr_listing=reco_most_freq_chef_curr_listing
    end
    id_top5 = Listing.top5
    @top5 = Listing.get_objects_by_id(id_top5) - past_listings
    #reputation_for(:votes).to_i
    result = []
    @anti_reco=[]
    cuisines=[]
    @cuisine_based_reco=[]
    @profile_based_reco=[]
    past_orders.each {|x| cuisines.append(x.listing.cuisine)}
    if !cuisines.nil?
      all_current_listings.each do |x|
        if x.cuisine.in? cuisines
          @cuisine_based_reco.append(x)
        end
      end
    end
    s=""
    # flash[:success] = past_listings.count
    if !@user.cuisines.nil?
      all_current_listings.each do |x|
        if x.cuisine.in? @user.cuisines
          @profile_based_reco.append(x)
          s+=" "+x.item
        end
      end
    end

    @profile_based_reco = (@profile_based_reco - past_listings).first
    @anti_reco = (all_current_listings - @cuisine_based_reco).first
    @cuisine_based_reco = (@cuisine_based_reco - past_listings).first
  end
  def search_user
    @result = User.search_user(params[:search])
  end
  def create
    @user = User.new(user_params)
    @user.ip = "98.242.64.230"
      if @user.save
        sign_in @user
        UserMailer.welcome_email(@user).deliver
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
    @id_top5 = Listing.top5
    @hotcakes = Listing.get_objects_by_id(@id_top5)
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
