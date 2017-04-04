class User < ActiveRecord::Base
  #registers an inline callback directly after the before_save
  before_save{self.email = email.downcase if email.present?}

  #uses Ruby's validates function to ensure that name is presen
  validates :name, length:{minimum: 1, maximum: 100}, presence: true

  #we validate password with two separate validations
  validates :password, presence: true, length:{minimum: 6}, if: "password_digest.nil?"
  validates :password, length: {minimum: 6}, allow_blank: true

  #validates that email is present, unique, case insensitive, has minimum length
  validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 254}

  #uses Ruby's has_secure_password to add methods
  has_secure_password
end
