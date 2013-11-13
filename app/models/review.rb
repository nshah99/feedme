class Review < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  belongs_to :listing
  default_scope order('reviews.created_at DESC')
end
