class AlumnosController < ApplicationController
  before_action :set_alumno, only: [:show, :edit, :update, :destroy, :new_message]
  before_action :validate_session

  # GET /alumnos
  # GET /alumnos.json
  def index
    @alumnos = Alumno.all
  end

  # GET /alumnos/1
  # GET /alumnos/1.json
  def show
  end

  # GET /alumnos/new
  def new
    @alumno = Alumno.new
  end

  # GET /alumnos/1/edit
  def edit
  end

  # POST /alumnos
  # POST /alumnos.json
  def create
    @alumno = Alumno.new(alumno_params)

    respond_to do |format|
      if @alumno.save
        format.html { redirect_to @alumno, notice: 'Alumno was successfully created.' }
        format.json { render :show, status: :created, location: @alumno }
      else
        format.html { render :new }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alumnos/1
  # PATCH/PUT /alumnos/1.json
  def update
    respond_to do |format|
      if @alumno.update(alumno_params)
        format.html { redirect_to @alumno, notice: 'Alumno was successfully updated.' }
        format.json { render :show, status: :ok, location: @alumno }
      else
        format.html { render :edit }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alumnos/1
  # DELETE /alumnos/1.json
  def destroy
    @alumno.destroy
    respond_to do |format|
      format.html { redirect_to alumnos_url, notice: 'Alumno was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #Función cargar formulario mensaje
  def new_message
  end

  #Funcion recibe datos de formulario y manda a cargar lista mensajes
  def create_message
    @list_messages = Array.new
    create_list_messages(params[:alumno_numero], params[:message])         
    redirect_to alumnos_url, notice: 'Message was successfully sent.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alumno
      @alumno = Alumno.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alumno_params
      params.require(:alumno).permit(:nombre, :curso_id, :numero)
    end

    #Funcion crea lista mensajes y manda a enviar el mensaje
    def create_list_messages(alumno_numero, mensaje)      
      @list_messages.push( {"Mobile"=>alumno_numero, "Message"=>mensaje})
      send_message
    end    

    #Función que envía en mensaje
    def send_message
      data = @list_messages.to_json
      Net::HTTP.post_form URI('http://www.example.com/search.cgi'),
        { "data" => data, "username" => "papitest1", "password" => "clavetest1" }
    end

end