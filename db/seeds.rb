# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "[+] create 10 users"
(1..10).each do |i|
  user = User.create(
    name: "user#{i}",
    email: "user#{i}@mail.com",
    password: "user#{i}pass",
    password_confirmation: "user#{i}pass"
  )
  WalletUser.create(entity: user, balance: rand(100..300))
end
puts "[+] 10 user created"
team = Team.create(name: "Team Alpha")
WalletTeam.create(entity: team, balance: 5000)


