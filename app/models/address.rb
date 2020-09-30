class Address < ApplicationRecord
  belongs_to :customer

  with_options presence: true do
	  validates :zipcode, format: {with: /\A\d{7}\z/}, numericality: true
	  validates :ship_name
	  validates :address
	end



  def full_address
    self.zipcode + self.address + self.ship_name
  end
end
