```ruby
# Carga de los ficheros de configuración
require 'capybara'
include Capybara::DSL

# Inicializamos Capybara
Capybara.run_server = false
Capybara.default_driver = :selenium

# Se recorre 100 veces el bot para conseguir nuestro objetivo

(1..100).each do |i|
  # Acceso a la página
  visit "https://www.change.org/p/proh%C3%ADban-las-p%C3%A1ginas-pro-anorexia-y-pro-bulimia-en-internet"

  # Click en el botón de inscripción
  page.first(".js-sign-button").click

  # Se rellenan los campos nombre, apellidos y código postal
  page.all("input[type='text']").each do |input_text|
    case input_text['placeholder']
    when "Nombre"
      input_text.set "Mi nombre"
    when "Apellidos"
      input_text.set "Mis Apellidos"
    when "Código postal"
      input_text.set "13005"
    end
  end

  # Se rellena el campo e-mail. Cada iteración proporciona un e-mail diferente
  page.all("input[type='email']").first.set "mi_email_ruby#{i}@miemail.es"

  # Click en el botón de finalización
  page.all(".js-sign-button").first.click

  # Se cierra sesión
  sleep(5)
  page.find(".dropdown").find('a').click
  page.find('.dropdown-menu').all('li').last.find('a').click
  sleep(5)
end
```
