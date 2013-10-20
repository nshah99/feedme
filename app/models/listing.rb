class Listing < ActiveRecord::Base
  validate :email, presence: true, uniqueness: true
  validate :item, presence: true
  validate :name, presence: true
end
