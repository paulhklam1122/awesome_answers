User.create(first_name: "Paul", last_name: "Lam", email: "paullam007@gmail.com", password: "p", is_admin: true)

User.create(first_name: "Carey", last_name: "Lau", email: "ccliu2012@gmail.com", password: "t")

User.create(first_name: "Tofu", last_name: "Tofu", email: "tofu@gmail.com", password: "t")

User.create(first_name: "Panda", last_name: "Panda", email: "panda@gmail.com", password: "p")

300.times do
  q = Question.create title: Faker::Company.bs,
                      body:       Faker::Hipster.paragraph,
                      view_count: rand(100),
                      user_id: User.all.map(&:id).sample
  5.times { q.answers.create body: Faker::ChuckNorris.fact } if q.persisted?
end

["Sports", "Art", "Cats", "Technology", "News"].each do |cat|
  Category.create name: cat
end

puts Cowsay.say "Generated 300 questions!"

30.times do
  Tag.create title: Faker::Hacker.adjective
end
