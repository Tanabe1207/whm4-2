class Language < ApplicationRecord

  # has_many :user_language_levels, foreign_key:'language_id'
  # accepts_nested_attributes_for :user_language_levels

 belongs_to :user

end
