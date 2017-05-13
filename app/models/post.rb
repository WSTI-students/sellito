class Post < ApplicationRecord
  belongs_to :user
  validates :expiration_date, presence: true
end
