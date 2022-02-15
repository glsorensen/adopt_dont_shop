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
end
