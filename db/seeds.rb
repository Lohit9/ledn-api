# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

accounts_hash = JSON.parse(File.read("db/accounts.json"))
large_accounts_hash = JSON.parse(File.read("db/accounts_large.json"))
(accounts_hash + large_accounts_hash).each do |acc| 
  AccountHolder.create(
    first_name: acc["firstName"],
    last_name: acc["lastName"],
    country: acc["country"],
    email: acc["email"], 
    dob: acc["dob"],
    mfa: acc["mfa"], 
    amt: acc["amt"],
    createdDate: acc["createdDate"],
    referredBy: acc["referredBy"] 
  )
end
