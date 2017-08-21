class Doctor < ApplicationRecord
	has_many :seances, dependent: :destroy

	def full_name
		self.last_name + ' ' + self.name + ' ' + self.patronymic
	end
end
