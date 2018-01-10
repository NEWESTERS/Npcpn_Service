class AppController < ApplicationController
  def new
  end

  def show # отображение информации о записи
    @seance = Seance.find(params[:seance_id])
    @client = @seance.client
  end

  def db # метод, выполняющий запросы к БД
    case params[:to_find]
    when 'doctor'
      # находим все сеансы в выбранный день
      @result = Seance.where("to_char(date, 'DD-MM-YYYY') = ? and affilate_id = ?", params[:date], params[:affilate])
      # извлекаем только свободные сеансы
      @result = @result.select { |p| p.client.nil? }
      # извлекаем список врачей без повторов
      @result = @result.collect(&:doctor).uniq
      # извлекаем ФИО врача
      @result = @result.collect { |p| [p.full_name + ((rank = p.rank).nil? ? '' : (' — ' + rank)), p.id] }
      @result = [['0']] if @result.blank?
    when 'seance'
      # находим все сеансы выбранного врача в выбранный день
      @result = Seance.where("to_char(date, 'DD-MM-YYYY') = ? and doctor_id = ?", params[:date], params[:doctor_id])
      # извлекаем время свободных сеансов
      @result = @result.select { |p| p.client.nil? }.collect { |p| [p.date.strftime('%H:%M'), p.id] }
      @result = [['2']] if @result.blank?
    when 'is_schedule'
      # находим все сеансы выбранного врача в выбранный день
      @query = Seance.where("to_char(date, 'DD-MM-YYYY') = ? and doctor_id = ?", params[:date], params[:doctor_id])
      # определяем наличие сеансов
      @result = @query.blank? ? [['-']] : [['+']]
    end
    @result = [['1']] if @result.blank?
    render json: @result # рендерим JSON, который получит клиент
  end

  def add # метод, заполняющий поля БД
    if !(params[:is_moscow] == 'off' && params[:affilate] == '3')
      # проверяем, зарегистрирован ли пациент в базе
      @client = Client.where('name = ? and last_name = ? and phone = ?', params[:name], params[:last_name], params[:phone])[0]
      if @client.nil?
        # создаём новую запись пациента в БД и заполнияем поля
        @client = Client.new(:last_name => params[:last_name], 
                            :name => params[:name],
                            :patronymic => params[:patronymic],
                            :birthdate => params[:birthdate],
                            :email => params[:email],
                            :phone => params[:phone],
                            :is_moscow => params[:is_moscow])
      end
      if @client.valid?
        # находим сеанс, на который производится запись и задаём пациента
        @seance = Seance.find(params[:seance]) if !params[:seance].nil?
        if !@seance.nil? && @seance.client.nil?
          @seance.client = @client
          @seance.save
          # перенаправление на страницу с информацией о записи
          redirect_to action: 'show', seance_id: @seance.id
        else
          redirect_to root_path(message: "Не выбран сеанс")
        end
      else
        redirect_to root_path(message: "Введены некорректные данные")
      end
    else
      redirect_to root_path(message: "Запись в филиал \"" + Affilate.find_by_id(params[:affilate]).name + "\" платных пациентов осуществляется только по телефону 8-985-265-51-01")
    end
  end

  def feedback
    @feedback = Feedback.new(:last_name => params[:last_name],
                :name => params[:name],
                :patronymic => params[:patronymic],
                :email => params[:email],
                :theme => params[:theme],
                :text => params[:text])
    if @feedback.valid?
      @feedback.save
      AutoAnswerMailer.check_email(@feedback).deliver_now
      AutoAnswerMailer.repliable_email(@feedback).deliver_now
      # AutoAnswerMailer.dept_email(@feedback).deliver_now
      @msg = "Ваша обращение отправлено"
    else
      @msg = "Ваша обращение не отправлено"
    end
    redirect_to root_path(message: @msg)
  end
end
