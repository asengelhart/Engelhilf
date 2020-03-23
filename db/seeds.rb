# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create!(username: "Admin", email: "admin@example.com", password: "password", is_admin: true)
user = User.create!(username: "User McTestface", email: "user@example.com", password: "password", is_admin: false)

Ticket.create!(subject: "subject1", content: "content1", urgency: 0, user: user, closed: true)
Ticket.create!(subject: "subject2", content: "content2", urgency: 1, user: admin)
Ticket.create!(subject: "subject3", content: "content3", urgency: 2, user: user)