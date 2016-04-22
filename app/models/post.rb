class Post < ActiveRecord::Base
  validates :title, :location, presence: true
end
