20.times do |n|
  name = "Basic Words #{n + 1}"
  description = "Learn basic Japanese Words"
  Category.create!(name: name, description: description)
end

30.times do |i|
  name = "ahihi-#{i + 1}"
  email = "demo-#{i + 1}@ror.com"
  password = "123qwe"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password)
end
