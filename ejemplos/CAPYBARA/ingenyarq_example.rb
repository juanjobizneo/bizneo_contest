# Carga de los ficheros de configuración
require 'capybara'
#require 'capybara-webkit'
include Capybara::DSL

# Inicializamos Capybara
Capybara.run_server = false
#Capybara.default_driver = :webkit
Capybara.default_driver = :selenium

# Se recorre 100 veces el bot para conseguir nuestro objetivo

(1..2).each do |i|
  # Acceso a la página
  visit "http://ingenyarq.es/index.php/contacto/trabajo"


  # Se rellenan los campos nombre, apellidos y código postal
  page.all("input[type='text']").each do |input_text|
    case input_text['value']
    when "Nombre"
      input_text.set "Pepe"
    when "E-mail"
      input_text.set "aguito#{i}@gmail.com"
    when "Teléfono"
      input_text.set "926789987"
    end
  end


  # Se cierra sesión
  page.find("option[value='Búsqueda por Internet']").click
  page.find("button[type='submit']").click
end
