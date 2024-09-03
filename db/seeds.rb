# Accounts
Account.create!(
  first_name:  "Tolase",
  last_name:  "Adegbite",
  username: "lashe",
  email: "tolase@ywamextra.com",
  bio: "Child of God | Software Developer",
  password: "123456",
  password_confirmation: "123456",
  dob: "1995-12-10"
)

Account.create!(
  first_name:  "Test",
  last_name:  "User",
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

  # Ensure uniqueness
  while Account.exists?(username: username)
    username = Faker::Internet.username(specifier: 5..15)
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

# Create following relationships.
accounts = Account.all
account  = accounts.first
following = accounts[2..50]
followers = accounts[3..40]
following.each { |followed| account.follow(followed) }
followers.each { |follower| follower.follow(account) }