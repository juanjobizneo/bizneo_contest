# Carga de los ficheros de configuración
require 'capybara'
include Capybara::DSL

# Inicializamos Capybara
Capybara.run_server = false
Capybara.default_driver = :selenium

n_tweets = 50
url = "https://twitter.com/norcoreano"

visit url

page.first('.modal-close').click

# tweets = []
f = File.open('tweets.txt', 'a')

# take all tweets
total = page.first('.ProfileNav-value').text.delete(".").to_i

while page.all('.ProfileTweet-text').count < n_tweets
  page.execute_script "window.scrollTo(0,document.body.scrollHeight)"
  print "\r#{page.all('.ProfileTweet-text').count}"
end

puts

page.all('.ProfileTweet-text').each do |tweet|
  # tweets << tweet.text
  f.write(tweet.text+"\n" )
end
 
# puts tweet

f.close


