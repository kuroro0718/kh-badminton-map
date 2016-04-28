class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :organizer, class_name: "User", foreign_key: :user_id
  has_many :registrations

  validates :title, :address, presence: true
  geocoded_by :address
  after_validation :geocode

  has_attached_file :image, styles: { medium: "400x400>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def self.search(search)
    where("address LIKE?", "%#{search}%")
  end

  def editable_by?(user)
    user && user == organizer
  end
end
