class AppController < ApplicationController
  def new
  end

  def show # отображение информации о записи
  	@seance = Seance.find(params[:seance_id])
  	@client = @seance.client
  end

  def db # метод, выполняющий запросы к БД
  	case params[:to_find]
  	when "doctor"
  	  # находим все сеансы в выбранный день
  	  @result = Seance.where("to_char(date, 'DD-MM-YYYY') = ? and affilate_id = ?", params[:date], params[:affilate])
      # извлекаем только свободные сеансы
      @result = @result.select { |p| p.client.nil? }
  	  # извлекаем список врачей без повторов
  	  @result = @result.collect { |p| p.doctor }.uniq
  	  # извлекаем ФИО врача
  	  @result = @result.collect { |p| [p.full_name + ((rank = p.rank).nil? ? '' : (' — ' + rank)), p.id] }
      if @result.blank? then @result = [['Нет cвободных врачей']] end
  	when "seance"
  	  # находим все сеансы выбранного врача в выбранный день
  	  @result = Seance.where("to_char(date, 'DD-MM-YYYY') = ? and doctor_id = ?", params[:date], params[:doctor_id])
  	  # извлекаем время свободных сеансов
  	  @result = @result.select { |p| p.client.nil? }.collect { |p| [p.date.strftime('%H:%M'), p.id] }
      if @result.blank? then @result = [['—']] end
    when "is_schedule"
      # находим все сеансы выбранного врача в выбранный день
      @query = Seance.where("to_char(date, 'DD-MM-YYYY') = ? and doctor_id = ?", params[:date], params[:doctor_id])
      # определяем наличие сеансов
      @result = @query.blank? ? [['-']] : [['+']]
  	end
  	if @result.blank? then @result = [['Нет доступных вариантов']] end
    render :json => @result # рендерим JSON, который получит клиент
  end

  def add # метод, заполняющий поля БД
    # проверяем, зарегистрирован ли пациент в базе
    @client = Client.where("name = ? and last_name = ? and phone = ?", params[:name], params[:last_name], params[:phone])[0]
    if @client.nil? then
    	# создаём новую запись пациента в БД и заполнияем поля
    	@client = Client.new
    	@client.last_name = params[:last_name]
    	@client.name = params[:name]
    	@client.patronymic = params[:patronymic]
    	@client.birthdate = Date.strptime(params[:birthdate], '%d-%m-%Y')
    	@client.email = params[:email]
    	@client.phone = params[:phone]
    	@client.is_moscow = params[:is_moscow]
    	@client.save
    end
    # находим сеанс, на который производится запись и задаём пациента
    @seance = Seance.find(params[:seance])
    @seance.client = @client
    @seance.save
    # перенаправление на страницу с информацией о записи
  	redirect_to :action => "show", :seance_id => @seance.id
  end
end
