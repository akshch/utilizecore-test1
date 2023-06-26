class Address < ApplicationRecord
	validates :address_line_one, :city, :state, :country, :pincode, :mobile_number, presence: true
  validates :mobile_number, numericality: { only_integer: true }

	belongs_to :user
end
