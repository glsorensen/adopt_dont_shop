# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PetApplication.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
application_1 = Application.create!(name: "Gunnar Sorensen", address: "123 Fake Street", city: "Red Lodge", state: "MT", zipcode: "59068", description: "I'm a great dog Dad!", status: "in progress")
application_2 = Application.create!(name: "Priska Sorensen", address: "123 Fake Street", city: "Red Lodge", state: "MT", zipcode: "59068", description: "I'm a great dog mom!", status: "in progress")
application_3 = Application.create!(name: "Lynn Sorensen", address: "123 Fake Street", city: "Red Lodge", state: "MT", zipcode: "59068", description: "I'm a great dog mom!", status: "in progress")

shelter_1 = Shelter.create(name: 'Red Lodge Shelter', city: 'Red Lodge, MT', foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: 'Help for Homeless Pets', city: 'Red Lodge, MT', foster_program: true, rank: 10)
shelter_3 = Shelter.create(name: 'Yellowstone Valley Animal Shelter', city: 'Billings, MT', foster_program: false, rank: 6)
shelter_4 = Shelter.create(name: 'Bark Animal Shelter', city: 'Billings, MT', foster_program: true, rank: 8)

pet_1 = Pet.create!(name: 'Sakic', breed: 'Groenendael', age: 1, adoptable: true, shelter_id: shelter_1.id)
pet_2 = Pet.create!(name: 'Onyx', breed: 'Standard Poodle', age: 4, adoptable: true, shelter_id: shelter_1.id)
pet_3 = Pet.create!(name: 'Valla', breed: 'Rottweiler', age: 2, adoptable: true, shelter_id: shelter_2.id)
pet_4 = Pet.create!(name: 'Rusty', breed: 'Chocolate Lab', age: 1, adoptable: true, shelter_id: shelter_2.id)
pet_5 = Pet.create!(name: 'Nichola', breed: 'Doberman', age: 4, adoptable: true, shelter_id: shelter_3.id)
pet_6 = Pet.create!(name: 'Cupid', breed: 'Doodle', age: 2, adoptable: true, shelter_id: shelter_3.id)
pet_7 = Pet.create!(name: 'Beaujoalais', breed: 'Irish Setter', age: 3, adoptable: true, shelter_id: shelter_4.id)
pet_8 = Pet.create!(name: 'Racer', breed: 'St. Bernard', age: 1, adoptable: true, shelter_id: shelter_4.id)

PetApplication.create!(pet: pet_1, application: application_2)
PetApplication.create!(pet: pet_2, application: application_2)

PetApplication.create!(pet: pet_3, application: application_3)
PetApplication.create!(pet: pet_4, application: application_3)
