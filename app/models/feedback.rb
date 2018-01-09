class Feedback < ApplicationRecord
	validates :name, format: { with: /\A[а-яА-Я]+[ -]?[а-яА-Я]*\z/, message: "Should contain only letters" }
	validates :last_name, format: { with: /\A[а-яА-Я]+[ -]?[а-яА-Я]*\z/, message: "Should contain only letters" }
	validates :patronymic, format: { with: /\A[а-яА-Я]+[ -]?[а-яА-Я]*\z/, message: "Should contain only letters" }
	validates :email, format: { with: /\A[a-zA-Z._\-0-9]+[@][a-zA-Z]+[.][a-zA-Z]+\z/, message: "Should be valid email"}

	def full_name
		last_name + ' ' + name + ' ' + patronymic
	end
end
