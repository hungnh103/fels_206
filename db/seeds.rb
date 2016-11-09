20.times do |i|
  name = "Basic Words #{i + 1}"
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

40.times do |i|
  w_content = "word no. #{i + 1}"
  a_content = "ans no.#{i + 1}"
  category_id = 2
  Word.create!(content: w_content, category_id: category_id)
  Answer.create!(content: a_content, is_correct: "t", word_id: i + 1)
end

15.times do |i|
  user_id = 1
  category_id = 2
  Lesson.create!(user_id: user_id, category_id:category_id)
end

15.times do |i|
  user_id = 1
  category_id = 3
  Lesson.create!(user_id: user_id, category_id:category_id)
end

15.times do |i|
  lesson_id = 1
  word_id = i+1
  answer_id = i+1
  Result.create!(lesson_id: lesson_id, word_id: word_id, answer_id: answer_id)
end

15.times do |i|
  lesson_id = 16
  word_id = 16+i
  answer_id = 16+i
  Result.create!(lesson_id: lesson_id, word_id: word_id, answer_id: answer_id)
end
