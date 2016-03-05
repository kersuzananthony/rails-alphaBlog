class Category < ActiveRecord::Base

  # Relationship
  has_many :article_categories
  has_many :articles, through: :article_categories

  # Validation
  validates :name, presence: true
  validates_uniqueness_of :name
  validates_length_of :name, minimum: 3, maximum: 25

end