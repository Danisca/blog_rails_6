class Article < ApplicationRecord
	belongs_to :user
        has_many :article_categories
        has_many :categories, through: :article_categories
	validates :title,:description, presence: true
end
