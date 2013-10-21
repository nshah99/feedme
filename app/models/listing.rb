class Listing < ActiveRecord::Base
  #validate :email, presence: true, uniqueness: true
  #validate :item, presence: true
  #validate :name, presence: true
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :item, presence: true
  validates :user_id, presence:true
  
 def self.search(search)
    if search
      find(:all, :conditions => ['item LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end 
