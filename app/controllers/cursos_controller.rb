class CursosController < ApplicationController
  before_action :set_curso, only: [:show, :edit, :update, :destroy, :new_message]
  before_action :validate_session

  # GET /cursos
  # GET /cursos.json
  def index
    @cursos = Curso.all
  end

  # GET /cursos/1
  # GET /cursos/1.json
  def show
  end

  # GET /cursos/new
  def new
    @curso = Curso.new
  end

  # GET /cursos/1/edit
  def edit
  end

  # POST /cursos
  # POST /cursos.json
  def create
    @curso = Curso.new(curso_params)

    respond_to do |format|
      if @curso.save
        format.html { redirect_to @curso, notice: 'Curso was successfully created.' }
        format.json { render :show, status: :created, location: @curso }
      else
        format.html { render :new }
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cursos/1
  # PATCH/PUT /cursos/1.json
  def update
    respond_to do |format|
      if @curso.update(curso_params)
        format.html { redirect_to @curso, notice: 'Curso was successfully updated.' }
        format.json { render :show, status: :ok, location: @curso }
      else
        format.html { render :edit }
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cursos/1
  # DELETE /cursos/1.json
  def destroy
    @curso.destroy
    respond_to do |format|
      format.html { redirect_to cursos_url, notice: 'Curso was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_message
  end

  def create_message
    @list_messages = Array.new
    @curso = Curso.find(params[:id_curso])
    create_list_messages(params[:message])
    redirect_to cursos_url, notice: 'Message was successfully sent.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curso
      @curso = Curso.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def curso_params
      params.require(:curso).permit(:nombre, :colegio_id)
    end

    #Funcion crea lista mensajes y manda a enviar el mensaje
    def create_list_messages(mensaje)
      (@curso.alumnos).each do |alumno|
        @list_messages.push( {"Mobile"=>alumno.numero, "Message"=>mensaje})
      end
      send_message
    end

    #Función que envía en mensaje
    def send_message
      require 'net/http'
      data = @list_messages.to_json
      resp = Net::HTTP.post_form URI("http://52.3.188.254/Send.php"), { "data" => data, "username" => "papitest1", "password" => "clavetest1" }
    end
end
