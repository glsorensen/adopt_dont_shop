require 'rails_helper'

RSpec.describe 'application creation' do
  let!(:application_1) {Application.create!(name: "Gunnar Sorensen", address: "123 Fake Street", city: "Red Lodge", state: "MT", zipcode: "59068", description: "I'm a great dog Dad!", status: "in progress")}

  describe 'the application new' do
      it 'renders the new form' do
          visit "/applications/new"

          expect(page).to have_content("New Application")
          expect(find('form')).to have_content("Name")
          expect(find('form')).to have_content("Address")
          expect(find('form')).to have_content("City")
          expect(find('form')).to have_content("State")
          expect(find('form')).to have_content("Zipcode")
      end
  end

  describe 'the application create' do
      context 'given valid data' do
          it 'creates the application and redirects to the application show' do
              visit "/applications/new"
              fill_in 'Name', with: "Gunnar Sorensen"
              fill_in "Address", with: "123 Fake Street"
              fill_in 'City', with: "Red Lodge"
              fill_in 'State', with: "MT"
              fill_in 'Zipcode', with:'59068'
              click_button 'Save'
              expect(page).to have_current_path("/applications/#{application_1.id + 1}")
              expect(page).to have_content("Gunnar Sorensen")
              save_and_open_page
          end
      end

      context 'given invalid data' do
          it 're-renders the new form' do
              visit "/applications/new"
              click_button 'Save'
              expect(page).to have_current_path("/applications/new")
              expect(page).to have_content("Error: Name can't be blank, Address can't be blank, City can't be blank, State can't be blank, Zipcode can't be blank")
          end
      end
  end
end
