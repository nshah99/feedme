include SessionsHelper
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
    
      if params[:search].nil? && params[:location].nil?
        @listing = Listing.search("")
        return @listing
      end
      item = Listing.search(params[:search])

      if params[:close]==1.to_s
        location = Listing.near(params[:location],1)
      elsif params[:far]==1.to_s
        location = Listing.near(params[:location],5)
      else
         location = Listing.near(params[:location],100)
      end
      @listing = item & location
      #flash[:failure] = @listing.count.to_s+"/"+item.count.to_s+"before i"+location.count.to_s
      if @listing.count == 0 && params[:location]==""
       @listing = Listing.search(params[:search])
         #flash[:success] = @listing.count
      end
      #@nearby = Listing.search(params[:search])
      cheap=average=expensive=[]
      
      if params[:cheap]==1.to_s
       cheap = Listing.find(:all,:conditions=>['price between ? AND ?',0,5])&@listing
      end
      if params[:average]==1.to_s
       average = Listing.find(:all,:conditions=>['price between ? AND ?',5,15])&@listing
      end
      if params[:expensive]==1.to_s
       expensive = Listing.find(:all,:conditions=>['price between ? AND ?',15,50])&@listing
      end
      
      a = cheap+(average)+(expensive)
      if a.count==0 && params[:cheap]!=1.to_s && params[:average]!=1.to_s && params[:expensive]!=1.to_s
         
         #flash[:success] = "a ka count hai zero"+@listing.count.to_s
      else

         @listing = a
	#flash[:success] = "ddddddd "+average.count.to_s
      end
  end

  def show
    @listing = Listing.find(params[:id])
    @a = current_user
    @review = Review.new
    current_listings = Listing.ordered_by_time
    @reco = Listing.get_similar_listings(@listing)
  end
  def delete
  end

  def create 
    @listing = Listing.new(listing_params)

    user = User.find_by(email: @listing.email)
    @listing.user_id = user.id
    @listing.expected_time = params[:expected_time]
    ts = @listing.expected_time
    ds = @listing.expected_date

    @listing.expected_time = DateTime.new(ds.year,ds.month,ds.day,ts.hour,ts.min,ts.sec)
 
    if @listing.save
      
       flash[:succes] = "Great success"
       redirect_to @listing
    else
      render 'new'
    end
  end
  
  def vote
    value = params[:type] == "up" ? 1 : -1
    @listing = Listing.find(params[:id])
    @listing.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting"
  end
  
  def listing_params
    params.require(:listing).permit(:tags,:count,:name,:email,:item,:price,:quantity,:address,:is_ordered,:cuisine,:expected_date,:expected_time,:picture)
  end

end
