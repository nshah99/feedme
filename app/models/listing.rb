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

  # Added for reputation-system
  has_reputation :votes, source: :user, aggregated_by: :sum
 def self.search(search)
    
    if search.nil?
      search=""
    end
    search_condition = "%" + search + "%"
    if search
      find(:all, :conditions => ['item LIKE ? OR address LIKE ?', search_condition, search_condition])
    else
      find(:all)
    end
  end
end 
