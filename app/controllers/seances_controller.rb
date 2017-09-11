class SeancesController < ApplicationController
  before_action :set_seance, only: [:show, :edit, :update, :destroy]
  before_action :auth_filter, except: [:show]

  def auth_filter
    if current_user.nil? || current_user.email != 'admin'
      redirect_to root_path
    end
  end

  def generator
  end

  # дублирование расписания с одной даты на другую
  def duplicate
    @target = params[:target].split('-')
    @source = Seance.where("to_char(date, 'DD-MM-YYYY') = ?", params[:source])
    # копируем каждый сеанс по отдельности
    @source.map do |e| 
      @seance = Seance.new
      # записываем время от источника и дату от цели
      @seance.date = Time.new(@target[2].to_i, @target[1].to_i, @target[0].to_i, e.date.hour, e.date.min, 0) #.advance(hours: 3)
      @seance.doctor_id = e.doctor_id
      @seance.save 
    end
    redirect_to seances_path(date: params[:target])
  end

  def duplicator
  end

  # удаление сеансов в заданную дату у заданного врача
  def clear(doc, date)
    @arr = Seance.where("to_char(date, 'DD-MM-YYYY') = ? and doctor_id = ?", date, doc)
    @arr.each { |e| e.destroy }
  end

  # генерация расписания
  def generate
    # удаляем существующее расписание 
    clear(params[:doctor], params[:date])
    # в переменной current будет храниться время, записываемое в данный момент
    # в переменной end будет храниться время, до которого будет выполняться цикл создания сеансов
    # записываем в current время начала приёма
    @current = params[:date] + '/' + params[:start_hour] + ':' + params[:start_minute]
    # .advance(hours: 3) — костыль для локализации времени, без него время смещается на 3 часа от нужного
    @current = Time.strptime(@current, '%d-%m-%Y/%H:%M') #.advance(hours: 3)
    # если есть перерыв, то в end записываем начало перерыва, иначе — конец приёма
    if params[:break] == '1'
      @end = params[:date] + '/' + params[:break_start_hour] + ':' + params[:break_start_minute]     
      @end = Time.strptime(@end, '%d-%m-%Y/%H:%M') #.advance(hours: 3)
    else
      @end = params[:date] + '/' + params[:end_hour] + ':' + params[:end_minute]
      @end = Time.strptime(@end, '%d-%m-%Y/%H:%M') #.advance(hours: 3)      
    end
    # length — длительность приёма
    @length = params[:length].to_i
    @doctor_id = params[:doctor].to_i
    # цикл, создающий сеансы во временном интервале от current до end
    while @current < @end
      @seance = Seance.new
      @seance.date = @current
      @seance.doctor_id = @doctor_id
      @seance.save
      # смещаем current на время приёма
      @current = @current.advance(minutes: @length)    
    end
    # если есть перерыв, то записываем в current конец перерыва, а в end — конец приёма
    # затем снова повторяем цикл создания сеансов
    if params[:break] == '1'
      @current = params[:date] + '/' + params[:break_end_hour] + ':' + params[:break_end_minute]    
      @current = Time.strptime(@current, '%d-%m-%Y/%H:%M') #.advance(hours: 3)
      @end = params[:date] + '/' + params[:end_hour] + ':' + params[:end_minute]
      @end = Time.strptime(@end, '%d-%m-%Y/%H:%M') #.advance(hours: 3)

      while @current < @end
        @seance = Seance.new
        @seance.date = @current
        @seance.doctor_id = @doctor_id
        @seance.save
        @current = @current.advance(minutes: @length)    
      end
    end    

    redirect_to seances_path(date: params[:date])  
  end

  # GET /seances
  # GET /seances.json
  def index
    @date = params[:date].blank? ? Time.now.strftime("%d-%m-%Y") : params[:date]
    # @seances = Seance.where("strftime('%d-%m-%Y', date) = ?", @date)
    @seances = Seance.where("to_char(date, 'DD-MM-YYYY') = ?", @date).sort_by{ |s| [s.doctor.full_name, s.date] }
    # @seances = Seance.all
  end

  # GET /seances/1
  # GET /seances/1.json
  def show
  end

  # GET /seances/new
  def new
    @seance = Seance.new
  end

  # GET /seances/1/edit
  def edit
  end

  # POST /seances
  # POST /seances.json
  def create
    @seance = Seance.new(seance_params)

    respond_to do |format|
      if @seance.save
        format.html { redirect_to @seance, notice: 'Seance was successfully created.' }
        format.json { render :show, status: :created, location: @seance }
      else
        format.html { render :new }
        format.json { render json: @seance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seances/1
  # PATCH/PUT /seances/1.json
  def update
    respond_to do |format|
      if @seance.update(seance_params)
        format.html { redirect_to @seance, notice: 'Seance was successfully updated.' }
        format.json { render :show, status: :ok, location: @seance }
      else
        format.html { render :edit }
        format.json { render json: @seance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seances/1
  # DELETE /seances/1.json
  def destroy
    @seance.destroy
    respond_to do |format|
      format.html { redirect_to seances_url, notice: 'Seance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seance
      @seance = Seance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seance_params
      params.require(:seance).permit(:date, :doctor_id, :client_id)
    end
end
