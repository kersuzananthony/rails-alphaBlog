class Category < ActiveRecord::Base

  validates :name, presence: true
  validates_uniqueness_of :name
  validates_length_of :name, minimum: 3, maximum: 25

end