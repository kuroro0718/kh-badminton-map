class Post < ActiveRecord::Base
  validates :title, :address, presence: true
  geocoded_by :address
  after_validation :geocode
end
