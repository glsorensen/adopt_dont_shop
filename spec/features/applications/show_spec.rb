require 'rails_helper'

RSpec.desccribe 'as a visitor' do
  describe 'when I visit the applications show page it' do

    let!(shelter_1) {Shelter.create(name: 'Red Lodge Shelter', city: 'Red Lodge, MT', foster_program: false, rank: 9)}
    let!(pet_1) {Pet.create!(name: 'Sakic', breed: 'Groenendael', age: 1, adoptable: true, shelter_id: shelter_1.id)}
    let!(pet_2) {Pet.create!(name: 'Onyx', breed: 'Standard Poodle', age: 4, adoptable: true, shelter_id: shelter_1.id)}
    let!(application_1) {Application.create!(name: "Gunnar Sorensen", street_address: "123 Fake Street", city: "Red Lodge", state: "MT", zipcode: "59068")}

    before :each do
      PetApplication.create!(pet: pet_1, application: application_1)
      PetApplication.create!(pet: pet_2, application: application_1)

    it 'lists the attributes of an applicant and application' do

     expect(page).to have_content("Applicant: Gunnar Sorensen")
     expect(page).to have_content("Address: 123 Fake Street")
     expect(page).to have_content("City: Red Lodege")
     expect(page).to have_content("State: MT")
     expect(page).to have_content("Zip Code: 59068")
   end

   it 'displays any pets that are on the application' do

     expect(page).to have_content("Pet's Applied For")
     expect(page).to have_content("Sakic")
     expect(page).to have_content("Onyx")
   end

   it 'each pet name is a link to its show page' do

     within("#pet_#{pet_1.id}") do
       expect(page).to have_link("Sakic")
       click_on "Sakic"
       expect(current_path).to eq("/pets/#{pet_1.id}")
     end

     visit application_path(application_1)

     within("#pet_#{pet_2.id}") do
       expect(page).to have_link("Onyx")
       click_on "Onyx"
       expect(current_path).to eq("/pets/#{pet_2.id}")
     end
   end

   it 'displays the applications status' do

     expect(page).to have_content("Application Status: in progress")
   end
  end
end
