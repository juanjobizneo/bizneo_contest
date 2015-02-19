# Carga de los ficheros de configuración
require 'capybara'
include Capybara::DSL

# Inicializamos Capybara
Capybara.run_server = false
Capybara.default_driver = :selenium

url = "http://webpub.esi.uclm.es/directorio/busqueda"

visit url

File.open(ENV['HOME'] + '/metadata/professor.csv', 'w') do |f|
  page.all('.home-module').each do |professor|
    name = web = email = ""
    name = professor.first('.header a').text
    if web_link = professor.first('.grid_3').all('li:not(.list-omega)')[3].first('a')
      web = web_link['href']
    end
    email = professor.first('.grid_3 .list-omega a').text

    f.puts name + ";" + web + ";" + email
  end
end
