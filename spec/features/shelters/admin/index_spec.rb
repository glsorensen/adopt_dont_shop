require 'rails_helper'

RSpec.describe 'the admin shelters index' do

  it 'shelters are sorted in reverse alphabetical order by name' do
    rls = Shelter.create(name: 'Red Lodge Shelter', city: 'Red Lodge, MT', foster_program: false, rank: 9)
    hfhp = Shelter.create(name: 'Help for Homeless Pets', city: 'Red Lodge, MT', foster_program: true, rank: 10)
    yvas = Shelter.create(name: 'Yellowstone Valley Animal Shelter', city: 'Billings, MT', foster_program: false, rank: 6)
    bas  = Shelter.create(name: 'Bark Animal Shelter', city: 'Billings, MT', foster_program: true, rank: 8)

    visit '/admin/shelters'

    expect(yvas.name).to appear_before(rls.name)
    expect(rls.name).to appear_before(hfhp.name)
    expect(hfhp.name).to appear_before(bas.name)
  end

  it 'shows shelters with pending applications' do
    application_1 = Application.create!(name: "Gunnar Sorensen", address: "123 Fake Street", city: "Red Lodge", state: "MT", zipcode: "59068", description: "I'm a great dog Dad!", status: "in progress")
    application_2 = Application.create!(name: "Priska Sorensen", address: "123 Fake Street", city: "Red Lodge", state: "MT", zipcode: "59068", description: "I'm a great dog mom!", status: "in progress")
    application_3 = Application.create!(name: "Lynn Sorensen", address: "123 Fake Street", city: "Red Lodge", state: "MT", zipcode: "59068", description: "I'm a great dog mom!", status: "in progress")

    shelter_1 = Shelter.create(name: 'Red Lodge Shelter', city: 'Red Lodge, MT', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'Help for Homeless Pets', city: 'Red Lodge, MT', foster_program: true, rank: 10)
    shelter_3 = Shelter.create(name: 'Yellowstone Valley Animal Shelter', city: 'Billings, MT', foster_program: false, rank: 6)
    shelter_4 = Shelter.create(name: 'Bark Animal Shelter', city: 'Billings, MT', foster_program: true, rank: 8)

    pet_1 = Pet.create!(name: 'Sakic', breed: 'Groenendael', age: 1, adoptable: true, shelter_id: shelter_1.id)
    pet_2 = Pet.create!(name: 'Onyx', breed: 'Standard Poodle', age: 4, adoptable: true, shelter_id: shelter_1.id)
    pet_3 = Pet.create!(name: 'Valla', breed: 'Rottweiler', age: 2, adoptable: true, shelter_id: shelter_1.id)
    pet_4 = Pet.create!(name: 'Rusty', breed: 'Chocolate Lab', age: 1, adoptable: true, shelter_id: shelter_1.id)
    pet_5 = Pet.create!(name: 'Nichola', breed: 'Doberman', age: 4, adoptable: true, shelter_id: shelter_3.id)
    pet_6 = Pet.create!(name: 'Cupid', breed: 'Doodle', age: 2, adoptable: true, shelter_id: shelter_3.id)
    pet_7 = Pet.create!(name: 'Beaujoalais', breed: 'Irish Setter', age: 3, adoptable: true, shelter_id: shelter_3.id)
    pet_8 = Pet.create!(name: 'Racer', breed: 'St. Bernard', age: 1, adoptable: true, shelter_id: shelter_4.id)

    PetApplication.create!(pet: pet_1, application: application_2)
    PetApplication.create!(pet: pet_2, application: application_2)
    PetApplication.create!(pet: pet_3, application: application_3)
    PetApplication.create!(pet: pet_4, application: application_3)
    PetApplication.create!(pet: pet_5, application: application_3)
    PetApplication.create!(pet: pet_6, application: application_1)
    PetApplication.create!(pet: pet_7, application: application_1)
    PetApplication.create!(pet: pet_8, application: application_1)

    visit "/admin/shelters"

    expect(page).to have_content("Shelter's with Pending Applications")

      within('#pending') do
        expect(page).to have_content(shelter_1.name)
        expect(page).to have_content(shelter_1.pet_count)
        expect(page).to have_content(shelter_2.name)
        expect(page).to have_content(shelter_2.pet_count)
        expect(page).to have_content(shelter_3.name)
        expect(page).to have_content(shelter_3.pet_count)
        expect(page).to have_content(shelter_4.name)
        expect(page).to have_content(shelter_4.pet_count)
      end
    end
  end
