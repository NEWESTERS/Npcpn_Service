class Affilate < ApplicationRecord
	has_many :doctors
	has_many :seances
	has_many :users
end
