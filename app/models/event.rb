class Event < ActiveRecord::Base
  
  has_many :attendees
  has_many :users, through: :attendees
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  default_scope -> { order('events.created_at DESC') }
  scope :current_event, where('events.event_date>?',Time.now)

  def self.search_event(search)
    search='%'+search+'%'
    a = find(:all, :conditions => ['title LIKE ?',search])
    return a
  end
end
