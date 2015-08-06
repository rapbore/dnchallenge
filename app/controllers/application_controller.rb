class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :validate_session

  private

  def login(username, password)
    #Verifica que el nombre de usuario y la contraseña sean correctos
    if username == "papi" and password == "notas"
      #Los datos son correctos entonces crea la sesión y devuelve true.
      session[:logueado] = true;
      session[:username] = "Papi";
      return true;
    else
      #Los datos no son correctos entonces devuelve false.
      return false;
    end
  end

  def logout
    #Desloguea al usuario.
    #session[:logueado] = false;
    #session[:username] = nil;
    reset_session
  end

  def get_login
    #Verifica si el usuario está logueado. Primero pregunta si existe la session[:logueado] y además que este sea true, si existe devuelve la sesión sino existe devuelve false.
    if defined?(session[:logueado]) and session[:logueado]
      #Está logueado.
      return session;
    else
      #No está logueado.
      return false;
    end
  end

  def validate_session
    @sesion = get_login();
    unless @sesion
      redirect_to welcome_iniciar_sesion_url
    end
  end

end
