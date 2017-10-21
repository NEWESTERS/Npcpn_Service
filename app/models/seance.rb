class Seance < ApplicationRecord
	belongs_to :doctor
	belongs_to :client, optional: true
	belongs_to :affilate, optional: true
end
