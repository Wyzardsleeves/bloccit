# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'random_data'

50.times do
  # creates new Post.
  Post.create!(
    # usees methods from teh class that doesn't exist yet
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end #Create post (50.times)

posts = Post.all
#calls times on an Integer
100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end #100.times

puts "#{Post.count}"
Post.find_or_create_by(title: "A unique title", body: "A unique body")
puts "#{Post.count}"

puts "Seed finished"
puts "#{Post.count} post created"
puts "#{Comment.count} comments created"
