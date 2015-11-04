# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(usuario: "example@mundofeliz.com",
             password:              "12345678",
             password_confirmation: "12345678",
             activated: true,
             activated_at: Time.zone.now)


99.times do |n|
  email = "example-#{n+1}@mundofeliz.com"
  password = "12345678"
  User.create!(usuario: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end
