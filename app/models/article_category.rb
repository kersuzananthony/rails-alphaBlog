class ArticleCategory < ActiveRecord::Base

  # Relationship
  belongs_to :article
  belongs_to :category

end