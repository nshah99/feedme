class Event < ActiveRecord::Base
  
  has_many :attendees
  has_many :users, through: :attendees
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  default_scope -> { order('events.created_at DESC') }
end
