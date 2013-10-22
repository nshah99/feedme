class Listing < ActiveRecord::Base
  #validate :email, presence: true, uniqueness: true
  #validate :item, presence: true
  #validate :name, presence: true
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :item, presence: true
  validates :user_id, presence:true
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
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
