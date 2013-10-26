class Order < ActiveRecord::Base
  belongs_to :listing
  belongs_to :user
  has_one :review
  default_scope -> { order('created_at DESC') }
end
