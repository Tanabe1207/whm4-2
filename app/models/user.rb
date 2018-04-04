class User < ApplicationRecord
  has_secure_password
  mount_uploader :my_image, ImageUploader

  validates :nickname, presence: true
  validates :mail, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  #validates :my_image, presence: true
  enum gender:{男性:1, 女性:2}
  #validates :birthday, presence: true
  #validates :nationality, presence: true

  # has_many :user_language_levels, foreign_key: 'user_id'
  # accepts_nested_attributes_for :user_language_levels, allow_destroy: true, reject_if: :all_blank
  has_many :offers, dependent: :destroy
  has_many :languages

  has_many :favorites
  has_many :favorite_offers, through: :favorites, source: 'offer'

end

# t.string :nickname
# t.string :mail
# t.string :my_image
# t.string :gender
# t.date :birthday
# t.integer :age
# t.string :nationality
# t.string :offers
# t.string :favorites

# "Japan"
# "Korea"
# "Taiwan"
# "Hong Kong"
# "China"
# "Australia"
# "New Zealand"
# "France"
# "German"
# "Nederland"
# "Canada"
