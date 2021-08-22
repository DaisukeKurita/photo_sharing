50.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = 'pwassword'
  User.create!(
    profile_image: open("./db/fixtures/profile_image.png"),
    name: name,
    email: email,
    password: password,
    password_confirmation: password
  )
end
