class Listing < ActiveRecord::Base
  #validate :email, presence: true, uniqueness: true
  #validate :item, presence: true
  #validate :name, presence: true
  belongs_to :user
  has_many :reviews
  has_many :orders
  #default_scope -> { order('listings.created_at DESC') }
  scope :ordered_by_time, :conditions=>['expected_time>?',Time.now],:order=> "expected_time"
  scope :top5,
    select("listings.id, count(orders.id) AS orders_count").
    joins(:orders).
    where("listings.expected_time>?",Time.now).
    group("listings.id").
    order("orders_count DESC")
    #limit(5)
  validates :item, presence: true
  validates :user_id, presence:true
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  mount_uploader :picture, PictureUploader


  # Added for reputation-system
  has_reputation :votes, source: :user, aggregated_by: :sum
 def self.search(search)
    
    if search.nil?
      search=""
    end
    search_condition = "%" + search + "%"
    if !search.empty?
      find(:all, :conditions => ['item LIKE ? OR address LIKE ?', search_condition, search_condition]) & 
	find(:all,:conditions => ['quantity >? AND expected_time>?',0,Time.now])
    else
      
      find(:all,:conditions => ['quantity >? AND expected_time>?',0,Time.now],:order=>"expected_time")
      #find(:all)

    end
  end

  def self.decrement_quantity(id,count)
    
    l = find(id)
    quant = l.quantity
    diff = quant - count
    if diff>-1
    l.update(quantity:diff)
    true
    else
    false
    end
    
  end
  
  def self.get_similar_listings(listing)
    cuisine = listing.cuisine.split(',').collect{|x| x.strip}
    result = []
    Listing.all.each do |f|
      if f.id !=listing.id
        x = f.cuisine.split(',').collect{|x| x.strip}
          if cuisine.any?{ |w| x.include?(w)}
            result.append(f)
          end
      end
    end
    return result
  end

  def self.get_objects_by_id(id_list)
    result = []
    id_list.each do |f|
      result.append(find(f.id))
    end
    return result
  end

end 
