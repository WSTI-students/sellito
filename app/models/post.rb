class Post < ApplicationRecord
  scope :featured_posts, lambda {
                                  includes(:categories)
                                    .order('created_at DESC')
                                    .limit(10)
                                }
  belongs_to :user
  has_many :post_categories
  has_many :categories, through: :post_categories
end
