class Client < ApplicationRecord
	has_many :seances
	validates :name, format: { with: /\A[а-яА-Я]+[ -]?[а-яА-Я]*\z/, message: "Should contain only letters" }
	validates :last_name, format: { with: /\A[а-яА-Я]+[ -]?[а-яА-Я]*\z/, message: "Should contain only letters" }
	validates :patronymic, format: { with: /\A[а-яА-Я]+[ -]?[а-яА-Я]*\z/, message: "Should contain only letters" }
	validates :birthdate, presence: true
	validates :phone, format: { with: /\A[+][7,8][ ][(][0-9]{3}[)][ ][0-9]{3}[-][0-9]{2}[-][0-9]{2}+\z/, message: "Should be valid phone" }
	before_save :convert_case

	def full_name
		last_name + ' ' + name + ' ' + patronymic
	end
end
