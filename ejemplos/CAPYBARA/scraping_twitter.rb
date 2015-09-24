# Carga de los ficheros de configuración
require 'capybara'
include Capybara::DSL

# Inicializamos Capybara
Capybara.run_server = false
Capybara.default_driver = :selenium

n_tweets = 10
url = "https://twitter.com/norcoreano"

visit url

page.first('.dropdown-signin').click

tweets = []
f = File.open('tweets.txt', 'a')

# take all tweets
while page.all('.TweetTextSize').count < n_tweets
  page.execute_script "window.scrollTo(0,document.body.scrollHeight)"
  print "\r#{page.all('.ProfileTweet-text').count}"
end

page.all('.TweetTextSize').each do |tweet|
  tweets << tweet.text
  puts tweet.text
  f.write(tweet.text+"\n" )
end

f.close


