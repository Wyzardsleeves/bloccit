class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #registers an inline callback directly after the before_save
  before_save{self.email = email.downcase if email.present?}
  before_save{self.role ||= :member}
  before_save :format_name

  #uses Ruby's validates function to ensure that name is presen
  validates :name, length:{minimum: 1, maximum: 100}, presence: true

  #we validate password with two separate validations
  validates :password, presence: true, length:{minimum: 6}, if: "password_digest.nil?"
  validates :password, length: {minimum: 6}, allow_blank: true

  #validates that email is present, unique, case insensitive, has minimum length
  validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 254}

  #uses Ruby's has_secure_password to add methods
  has_secure_password

  enum role: [:member, :moderator, :admin]

  def format_name
    if name
      name_array = []
      name.split.each do |name_part|
        name_array << name_part.capitalize
      end
      self.name = name_array.join(" ")
    end
  end #def format_name

  def favorite_for(post)
     favorites.where(post_id: post.id).first
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
end
