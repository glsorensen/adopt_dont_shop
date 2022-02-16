class Application < ApplicationRecord
  after_initialize :set_defaults

  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true

  def set_defaults
    self.description ||= ""
    self.status ||= "In Progress"
  end
  
  def pet_search(pet_name)
    Pet.where("name = ?", pet_name)
  end
end
