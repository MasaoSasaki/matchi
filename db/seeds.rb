# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin.create!(email: "daikichi852@icloud.com", password: "000000")
User.create!(email: 'daikichi852@icloud.com', password: '000000', name_family: '佐々木', name_first: '正男', name_family_kana: 'ササキ', name_first_kana: 'マサオ', phone_number: '09042745646')
