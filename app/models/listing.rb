class Listing < ActiveRecord::Base
  #validate :email, presence: true, uniqueness: true
  #validate :item, presence: true
  #validate :name, presence: true
  belongs_to :user
  has_many :reviews
  default_scope -> { order('created_at DESC') }
  validates :item, presence: true
  validates :user_id, presence:true
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  has_many :orders
  mount_uploader :picture, PictureUploader

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

end 
