# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(name: "Modeste", email: "Modeste@gmail.com", password: "......", password_confirmation: "......")
user.save!
user.tasks.create(name: "Premier tâche", details: "Je suis la premiere tache", expired_at: DateTime.now, status: "Completed", priority: "high")
User.create(name: "Momo", email: "momo@gmail.com", password: "......", password_confirmation: "......", is_admin: true)

tasks = Task.all

tasks.each do |task|
    task.update(user_id: User.last.id)
end
status = ["Unstarted", "Progress", "Completed"]
priority = ["low", "medium", "high"]

(1..10).each do |x|
    name = Faker::Lorem.word
    Label.create(name: name)
    User.create(name: "name#{x}", email: "example#{x}@gmail.com", password: "password")
    Task.create(name: "task_title#{x}", details: "content#{x}", status: status.sample, priority: priority.sample,user_id: User.last.id )
  
end
