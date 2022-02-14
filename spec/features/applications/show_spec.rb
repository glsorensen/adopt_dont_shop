require 'rails_helper'

RSpec.describe 'Application Show' do
  let!(:application_1) {Application.create!(name: "Gunnar Sorensen", address: "123 Fake Street", city: "Red Lodge", state: "MT", zipcode: "59068", description: "I'm a great dog Dad!", status: "in progress")}
  let!(:application_2) {Application.create!(name: "Priska Sorensen", address: "123 Fake Street", city: "Red Lodge", state: "MT", zipcode: "59068", description: "I'm a great dog mom!", status: "in progress")}
  let!(:application_3) {Application.create!(name: "Lynn Sorensen", address: "123 Fake Street", city: "Red Lodge", state: "MT", zipcode: "59068", description: "I'm a great dog mom!", status: "in progress")}

  let!(:shelter_1) {Shelter.create(name: 'Red Lodge Shelter', city: 'Red Lodge, MT', foster_program: false, rank: 9)}

  let!(:pet_1) {Pet.create!(name: 'Sakic', breed: 'Groenendael', age: 1, adoptable: true, shelter_id: shelter_1.id)}
  let!(:pet_2) {Pet.create!(name: 'Onyx', breed: 'Standard Poodle', age: 4, adoptable: true, shelter_id: shelter_1.id)}
  let!(:pet_3) {Pet.create!(name: 'Valla', breed: 'Rottweiler', age: 2, adoptable: true, shelter_id: shelter_1.id)}
  let!(:pet_4) {Pet.create!(name: 'Rusty', breed: 'Chocolate Lab', age: 1, adoptable: true, shelter_id: shelter_1.id)}
  let!(:pet_5) {Pet.create!(name: 'Nichola', breed: 'Doberman', age: 4, adoptable: true, shelter_id: shelter_1.id)}



  before :each do
    PetApplication.create!(pet: pet_1, application: application_1)
    PetApplication.create!(pet: pet_2, application: application_1)
  end


  it 'displays the name of the applicant' do

    visit "/applications/#{application_1.id}"

    within('#applicant-info') do
      expect(page).to have_content(application_1.name)
      expect(page).to have_content(application_1.address)
      expect(page).to have_content(application_1.city)
      expect(page).to have_content(application_1.state)
      expect(page).to have_content(application_1.zipcode)
      expect(page).to have_content(application_1.description)
      expect(page).to have_content(application_1.status)
    end

    within('#pet-names') do
      expect(page).to have_content(pet_1.name)
      click_on("#{pet_1.name}")
      expect(current_path).to eq("/pets/#{pet_1.id}")
    end
  end

  describe 'building an empty application' do

    before :each do
      visit "/applications/#{application_2.id}"
    end

    it 'allows for a search of pets by name' do

      expect(page).to have_content("Add a Pet to this Application")

      within('#search-pet')do
        fill_in(:pet_name, with: "Sakic")
        click_on("Search")
      end

      expect(current_path).to eq("/applications/#{application_2.id}")
      expect(page).to have_content(pet_1.name)
    end

  end
end
