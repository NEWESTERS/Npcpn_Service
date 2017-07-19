class Doctor < ApplicationRecord
	has_many :seances, dependent: :destroy
end
