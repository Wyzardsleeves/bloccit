class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  #assignment-22
  has_many :sponsored_posts, dependent: :destroy
end
