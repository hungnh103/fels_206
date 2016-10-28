20.times do |n|
  name = "Basic Words #{n + 1}"
  description = "Learn basic Japanese Words"
  Category.create!(name: name, description: description)
end
