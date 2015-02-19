# Carga de los ficheros de configuración
require 'capybara'
include Capybara::DSL

# Inicializamos Capybara
Capybara.run_server = false
Capybara.default_driver = :selenium


url = "https://twitter.com/norcoreano"

visit url

page.first('.modal-close').click

tweets = []

total = page.first('.ProfileNav-value').text.delete(",").to_i

while page.all('.ProfileTweet-text').count < total/10
  page.execute_script "window.scrollTo(0,document.body.scrollHeight)"
  print "\r#{page.all('.ProfileTweet-text').count}"
end

puts

page.all('.ProfileTweet-text').each do |tweet|
  tweets << tweet.text
end

puts tweets
