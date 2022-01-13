require 'json'

Comment.destroy_all
User.destroy_all

data = JSON.parse(File.read('FEM_Resources/data.json'))

User.create!(
  name: data["currentUser"]["username"],
  email: "#{data['currentUser']['username']}@email.com",
  password: "password",
  password_confirmation: "password"
)

data["comments"].each do |comment_data|
  user = User.new(
    name: comment_data["user"]["username"],
    email: "#{comment_data['user']['username']}@email.com",
    password: "password",
    password_confirmation: "password"
  )
  user_exists = User.find_by_name(user.name)
  user_exists ? user = user_exists : user.save!
  comment = Comment.new(
    reply: false,
    content: comment_data["content"],
    user: user,
    score: comment_data["score"]
  )
  comment.save!
  comment_data["replies"].each do |reply_data|
    reply_user = User.new(
      name: reply_data["user"]["username"],
      email: "#{reply_data['user']['username']}@email.com",
      password: "password",
      password_confirmation: "password"
    )
    user_exists = User.find_by_name(reply_user.name)
    user_exists ? reply_user = user_exists : reply_user.save!
    Comment.create!(
      comment_id: comment.id,
      reply: true,
      content: reply_data["content"],
      user: reply_user,
      score: reply_data["score"]
    )
  end
end
