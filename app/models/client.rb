class Client < ApplicationRecord
	has_many :seances
	validates :name, format: { with: /\A[а-яА-Я]+[ -]?[а-яА-Я]*\z/, message: "имя" }
	validates :last_name, format: { with: /\A[а-яА-Я]+[ -]?[а-яА-Я]*\z/, message: "фамилия" }
	validates :patronymic, format: { with: /\A[а-яА-Я]+[ -]?[а-яА-Я]*\z/, message: "отчество" }
	validates :birthdate, presence: { message: "дата рождения" }
	validates :phone, format: { with: /\A[+][7,8][ ][(][0-9]{3}[)][ ][0-9]{3}[-][0-9]{2}[-][0-9]{2}+\z/, message: "номер телефона" }

	def full_name
		last_name + ' ' + name + ' ' + patronymic
	end
end
