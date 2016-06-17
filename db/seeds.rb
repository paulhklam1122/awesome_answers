# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 300.times do
#   Question.create title: Faker::Company.bs,
#                     body: Faker::Hipster.paragraph,
#                     view_count: rand(100)
# end
#
# puts Cowsay.say "Generated 300 questions!"
#
# 100.times do
#   User.create first_name: Faker::Name.first_name,
#                 last_name: Faker::Name.last_name,
#                 email: Faker::Internet.email
# end


# 300.times do
#   Product.create name: Faker::Commerce.product_name,
#                    price: rand(1000),
#                    sale_price: rand(50)
# end

300.times do
  q = Question.create title:      Faker::Company.bs,
                      body:       Faker::Hipster.paragraph,
                      view_count: rand(100)
  5.times { q.answers.create body: Faker::ChuckNorris.fact } if q.persisted?
end

["Sports", "Art", "Cats", "Technology", "News"].each do |cat|
  Category.create name: cat
end

puts Cowsay.say "Generated 300 questions!"
