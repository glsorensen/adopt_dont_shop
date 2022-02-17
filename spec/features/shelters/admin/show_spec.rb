require 'rails_helper'

RSpec.describe 'the ADMIN application show' do
  it 'approve pet for adoption' do
    application_1 = Application.create!(name: "Gunnar Sorensen", address: "123 Fake Street", city: "Red Lodge", state: "MT", zipcode: "59068", description: "I'm a great dog Dad!")
    shelter_1 = Shelter.create(name: 'Red Lodge Shelter', city: 'Red Lodge, MT', foster_program: false, rank: 9)
    pet_1 = Pet.create!(name: 'Sakic', breed: 'Groenendael', age: 1, adoptable: true, shelter_id: shelter_1.id)
    pet_2 = Pet.create!(name: 'Onyx', breed: 'Standard Poodle', age: 4, adoptable: true, shelter_id: shelter_1.id)

    PetApplication.create!(pet: pet_1, application: application_1)
    PetApplication.create!(pet: pet_2, application: application_1)


    visit "/admin/applications/#{application_1.id}"

    expect(page).to have_button("Approve Sakic")
    expect(page).to have_button("Approve Onyx")
    click_button("Approve Sakic")

    expect(current_path).to eq("/admin/applications/#{application.id}")
    expect(page).to_not have_button("Approve Sakic")
    expect(page).to have_content("Sakic Approved")
    expect(page).to have_button("Approve Onyx")
  end
end
