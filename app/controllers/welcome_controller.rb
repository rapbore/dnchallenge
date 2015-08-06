class WelcomeController < ApplicationController

  before_action :validate_session, except: [:iniciar_sesion]

  def index
    @username = @sesion[:username]
  end

  def iniciar_sesion
    @error_login = false;
    #Verifica si se ha enviado el formulario.
    if request.post?
      #Verifica si el nombre de usuario y la contraseña son correctos.
      if login(params[:username], params[:password])

        #Los datos son correctos así que redirecciona a la página de bienvenida.
        redirect_to welcome_index_path
      else
        #Los datos son incorrectos así que setea la variable @error_login a true para mostrar el error por pantalla.
        @error_login = true;
      end
    end
  end

  def cerrar_sesion
    reset_session
    redirect_to root_url;
  end

  private


end
