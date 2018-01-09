json.extract! feedback, :id, :name, :last_name, :patronymic, :email, :theme, :text, :created_at, :updated_at
json.url feedback_url(feedback, format: :json)
