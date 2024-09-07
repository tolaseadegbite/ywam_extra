# # Accounts
# Account.create!(
#   first_name:  "Tolase",
#   last_name:  "Adegbite",
#   username: "lashe",
#   email: "tolase@ywamextra.com",
#   bio: "Child of God | Software Developer",
#   password: "123456",
#   password_confirmation: "123456",
#   dob: "1995-12-10"
# )

# Account.create!(
#   first_name:  "Test",
#   last_name:  "User",
#   username: "test_user",
#   email: "test@ywamextra.com",
#   bio: "I am Test!",
#   password: "123456",
#   password_confirmation: "123456",
#   dob: "1996-12-10"
# )

# 99.times do |n|
#   email = "example-#{n+1}@ywamextra.com"
#   username = Faker::Internet.username(specifier: 5..15)

#   while Account.exists?(username: username) || Account.exists?(email: email)
#     username = Faker::Internet.username(specifier: 5..15)
#     email = "example-#{n+rand(1..100)}@ywamextra.com"
#   end

#   Account.create!(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     bio: Faker::Lorem.paragraph(sentence_count: 2),
#     dob: Faker::Date.birthday(min_age: 18, max_age: 65),
#     username: username,
#     email: email,
#     password: 'password',
#     password_confirmation: 'password'
#   )
# end

# # Following relationships (Account -> Account)
# accounts = Account.all
# account  = accounts.first
# following = accounts[2..50]
# followers = accounts[3..40]
# following.each { |followed| account.follow(followed) }
# followers.each { |follower| follower.follow(account) }

# # Categories
# 20.times { Category.create!(name: Faker::Lorem.word.capitalize) }

# # Podcasts and Episodes
# accounts = Account.all
# categories = Category.all

# accounts.each do |account|
#   rand(1..2).times do
#     podcast = account.podcasts.create!(
#       name: Faker::Lorem.sentence(word_count: rand(2..5)).capitalize,
#       episodes_count: 0,
#       follows_count: 0,
#       category: categories.sample,
#       cover_art_url: Faker::Avatar.image(slug: "podcast-cover", size: "200x200", format: "jpg")
#     )
#     podcast.update!(about: Faker::Lorem.paragraph(sentence_count: 2))

#     rand(1..20).times do
#       episode = podcast.episodes.create!(
#         title: Faker::Lorem.sentence(word_count: 5),
#         follows_count: 0,
#         saves_count: 0,
#         episode_type: Episode.episode_types.keys.sample,
#         category: podcast.category,
#         cover_art_url: Faker::Avatar.image(slug: "episode-cover", size: "200x200", format: "jpg")
#       )
#       episode.update!(description: Faker::Lorem.paragraph(sentence_count: 2))
#     end
#   end
# end

# # Tags
# 30.times { Tag.create!(name: Faker::Lorem.word.capitalize) }

# # Assign Tags
# tags = Tag.all
# Podcast.all.each do |podcast|
#   rand(1..2).times { podcast.tags << tags.sample unless podcast.tags.include?(tags.sample) }
# end

# Episode.all.each do |episode|
#   rand(1..3).times { episode.tags << tags.sample unless episode.tags.include?(tags.sample) }
# end

# # Follow some podcasts
# 10.times do
#   podcast = Podcast.all.sample
#   account = Account.all.sample
#   account.follows.find_or_create_by!(followable: podcast)
# end

# # Follow some episodes
# 10.times do
#   episode = Episode.all.sample
#   account = Account.all.sample
#   account.follows.find_or_create_by!(followable: episode)
# end

# Accounts
puts "Creating accounts..."
Account.create!(
  first_name: "Tolase",
  last_name: "Adegbite",
  username: "lashe",
  email: "tolase@ywamextra.com",
  bio: "Child of God | Software Developer",
  password: "123456",
  password_confirmation: "123456",
  dob: "1995-12-10"
)

Account.create!(
  first_name: "Test",
  last_name: "User",
  username: "test_user",
  email: "test@ywamextra.com",
  bio: "I am Test!",
  password: "123456",
  password_confirmation: "123456",
  dob: "1996-12-10"
)

99.times do |n|
  email = "example-#{n+1}@ywamextra.com"
  username = Faker::Internet.username(specifier: 5..15)

  while Account.exists?(username: username) || Account.exists?(email: email)
    username = Faker::Internet.username(specifier: 5..15)
    email = "example-#{n+rand(1..100)}@ywamextra.com"
  end

  Account.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    bio: Faker::Lorem.paragraph(sentence_count: 2),
    dob: Faker::Date.birthday(min_age: 18, max_age: 65),
    username: username,
    email: email,
    password: 'password',
    password_confirmation: 'password'
  )
end

# Following relationships (Account -> Account)
puts "Creating following relationships..."
accounts = Account.all
account  = accounts.first
following = accounts[2..50]
followers = accounts[3..40]
following.each { |followed| account.follow(followed) }
followers.each { |follower| follower.follow(account) }

# Categories
puts "Creating categories..."
20.times { Category.create!(name: Faker::Lorem.word.capitalize) }

# Podcasts and Episodes
puts "Creating podcasts and episodes..."
ActiveRecord::Base.transaction do
  accounts.each do |account|
    rand(1..2).times do
      podcast = account.podcasts.create!(
        name: Faker::Lorem.sentence(word_count: rand(2..5)).capitalize,
        episodes_count: 0,
        follows_count: 0,
        about: Faker::Lorem.paragraph(sentence_count: 2),
        category: Category.all.sample
      )

      rand(1..20).times do
        episode = podcast.episodes.create!(
          title: Faker::Lorem.sentence(word_count: 5),
          follows_count: 0,
          saves_count: 0,
          episode_type: Episode.episode_types.keys.sample,
          description: Faker::Lorem.paragraph(sentence_count: 2),
          category: podcast.category
        )
      end
    end
  end
end

# Tags
puts "Creating tags..."
30.times { Tag.create!(name: Faker::Lorem.word.capitalize) }

# Assign Tags to Podcasts
puts "Assigning tags to podcasts..."
tags = Tag.all

Podcast.find_each do |podcast|
  podcast.tags << tags.sample(rand(1..5))
end

# Assign Tags to Episodes
puts "Assigning tags to episodes..."
Episode.find_each do |episode|
  episode.tags << tags.sample(rand(1..5))
end

# Follow some podcasts
puts "Creating follow relationships for podcasts..."
10.times do
  podcast = Podcast.all.sample
  account = Account.all.sample
  account.follows.find_or_create_by!(followable: podcast)
end

# Follow some episodes
puts "Creating follow relationships for episodes..."
10.times do
  episode = Episode.all.sample
  account = Account.all.sample
  account.follows.find_or_create_by!(followable: episode)
end

puts "Seeding completed at #{Time.now}"