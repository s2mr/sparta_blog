class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  
  scope :find_newest_article, -> { order(created_at: :desc).limit(5) }
end
