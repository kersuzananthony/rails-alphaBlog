class User < ActiveRecord::Base

  # Relationship
  has_many :articles

  # Actions before save
  before_save  { self.email = email.downcase } # turn email value to lowercase

  # Validation
  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 25 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 105 },
            format: { with: VALID_EMAIL_REGEX }

  # Authentication
  has_secure_password

end