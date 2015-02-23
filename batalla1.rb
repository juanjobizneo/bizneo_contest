# Carga de los ficheros de configuración
require 'capybara'
#require 'capybara-webkit'
include Capybara::DSL

# Inicializamos Capybara
Capybara.run_server = false

#Capybara.default_driver = :webkit
Capybara.default_driver = :selenium

# Visitamos url
visit "http://178.62.87.247"

#login usuario
page.all("input[type='email']").first.set "base.dks@gmail.com"
page.all("input[type='password']").first.set "TVAPEC1234"
sleep(1)
page.all("input[type='submit']").first.click

#Login bot
page.all("input[type='email']").first.set "bot0@fakemail.com"
page.all("input[type='password']").first.set "11111111"
sleep(2)
page.all("input[type='submit']").first.click

#El resto de código no lo salvé ... aunque llegué a añadir followees ...

end
