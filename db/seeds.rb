# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  Admin.create!(
  [{
  id: 1,
  email: 'test@test',
  password: 'testtest',
  password_confirmation: 'testtest'
  }]
  )

	Customer.create!(
	[{
	id: 1,
	email: 'testtest@test',
	last_name: '木村', first_name: 'カエラ',
	last_name_kana: 'キムラ', first_name_kana: 'カエラ',
	zipcode: '0000000',
	address: '大阪府大阪市阿倍野区1190−10',
	tel: '09011119999',
	customer_status: true,
	password: 'aaaaaa',
	password_confirmation: 'aaaaaa',
},]
)
Genre.create!(
  [
    {
      id: 1,
      genre_name: 'ケーキ',
      genre_status: true
    },

    {
      id: 2,
      genre_name: 'プリン',
      genre_status: true
    },

    {
      id: 3,
      genre_name: '焼き菓子',
      genre_status: true
    },

    {
      id: 4,
      genre_name: 'キャンディ',
      genre_status: true
    },

    {
      id: 5,
      genre_name: 'まるごとバナナ',
      genre_status: true
    },
  ]
  )

Product.create!(
  [
    {
      id: 1,
      name: 'まるごとバナナ',
      introduction: 'バナナを丸ごと１本使いました。',
      genre_id: 2,
      price: 400,
      status: true,
    },

    {
      id: 2,
      name: 'まるごといちご',
      introduction: 'いちごを丸ごと一個だけ使いました。',
      genre_id: 2,
      price: 300,
      status: true,
    },
  ]
  )