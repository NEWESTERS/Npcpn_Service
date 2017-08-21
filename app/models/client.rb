class Client < ApplicationRecord
	has_many :seances

	def full_name
		self.last_name + ' ' + self.name + ' ' + self.patronymic
	end
end
