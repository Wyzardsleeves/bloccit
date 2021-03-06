# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'random_data'
include RandomData

#Create users
5.times do
  User.create!(
    name: RandomData.random_name,
    email: RandomData.random_email,
    password: RandomData.random_sentence
  )
end
users = User.all

15.times do
  Topic.create!(
    name:         RandomData.random_sentence,
    description:  RandomData.random_paragraph
  )
end
topics = Topic.all

50.times do
  # creates new Post.
  post = Post.create!(
    user: users.sample,
    # usees methods from teh class that doesn't exist yet
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  rand(1..5).times{post.votes.create!(value: [-1, 1].sample, user: users.sample)}

end #Create post (50.times)


posts = Post.all

#calls times on an Integer
100.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end #100.times

50.times do
  SponsoredPost.create!(
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    price: RandomData.random_integer
  )
end
sponsored_posts = SponsoredPost.all

=begin
100.times do
  Question.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    resolved: false
  )
end
=end

=begin
Post.find_or_create_by(title: "A unique title", body: "A unique body")
puts "#{Post.count}"
=end

#create an admin user
admin = User.create!(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)

#create a moderator
moderator = User.create!(
  name:     'Mod User',
  email:    'moderator@examle.com',
  password: 'helloworld',
  role:     'moderator'
)

#create a member
member = User.create!(
  name:     'Member User',
  email:    'member@example.com',
  password: 'helloworld',
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} post created"
puts "#{Comment.count} comments created"
puts "#{Vote.count} votes created"
puts "#{SponsoredPost.count} sponsored post created"
#puts "#{Question.count} questions created"
