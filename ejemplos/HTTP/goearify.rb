# coding: utf-8
require 'json'
require 'typhoeus'
require 'nokogiri'
require 'progressbar'

class Goearify

  GOEAR_LOGIN = "http://www.goear.com/lightbox/login?"
  GOEAR_DO_LOGIN ="http://www.goear.com/action/users/login"
  GOEAR_SEARCH = "http://www.goear.com/search/"

  attr_accessor :playlist_urls, :playlist_json, :unmatched_songs

  def login
    url = self.class::GOEAR_LOGIN

    response = Typhoeus.get self.class::GOEAR_LOGIN, followlocation: true , headers: nil, params: nil

    #GETCOOKIE
    cookies = response.headers['set-cookie']
    @cookies = cookies.is_a?(String) ? cookies : cookies.join('; ')

    body = {
      "user_name" => "########",
      "password" => "########",
      "back" => "http://www.goear.com/"
    }

    headers = {
      "Host" => "www.goear.com",
      "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:37.0) Gecko/20100101 Firefox/37.0",
      "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
      "Accept-Language" => "es-ES,es;q=0.8,en-US;q=0.5,en;q=0.3",
      "Accept-Encoding" => "gzip, deflate",
      "Referer" => "http://www.goear.com/",
      "DNT" => "1",
      "Connection" => "keep-alive",
      "Cookie" => @cookies
    }

    url = self.class::GOEAR_DO_LOGIN

    response = Typhoeus.post url, body: body, headers: headers, followlocation: false
    new_cookies = response.headers['set-cookie']
    @cookies = @cookies + "; " + new_cookies.join("; ")
  end

  def search search_field
    puts search_field
    headers = {
      "Host" => "www.goear.com",
      "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:37.0) Gecko/20100101 Firefox/37.0",
      "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
      "Accept-Language" => "es-ES,es;q=0.8,en-US;q=0.5,en;q=0.3",
      "DNT" => "1",
      "Content-Type" => "text/html",
      "Connection" => "keep-alive",
      "Cookie" => "visitor_country=Spain; _gauges_unique_day=1; _gauges_unique_month=1; _gauges_unique_year=1; _gauges_unique=1;" + @cookies
    }

    url =  self.class::GOEAR_SEARCH + search_field.gsub(/[\s*]/,"-")
    response = Typhoeus.get url, followlocation: true , headers: headers, params: nil
    parsed_body = Nokogiri::HTML(response.body)
    parsed_body.css(".group.board_content").first.css(".title h4 a").first.attr("href")
  end

  def obtain_song_url url
    begin
      headers = {
        "Host" => "www.goear.com",
        "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:37.0) Gecko/20100101 Firefox/37.0",
        "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "Accept-Language" => "es-ES,es;q=0.8,en-US;q=0.5,en;q=0.3",
        "DNT" => "1",
        "Content-Type" => "text/html",
        "Connection" => "keep-alive",
        "Cookie" => "visitor_country=Spain; _gauges_unique_day=1; _gauges_unique_month=1; _gauges_unique_year=1; _gauges_unique=1;" + @cookies
      }
      response = Typhoeus.get url, followlocation: true , headers: headers, params: nil
      parsed_body = Nokogiri::HTML(response.body)
      return  parsed_body.css("meta[property='og:audio']").attr("content").text
    rescue StandardError
      return nil
    end
  end

  def obtain_urls urls_json = @playlist_json
    @unmatched_songs = []
    @playlist_urls = []
    pbar = ProgressBar.new("URLS", playlist_json.count)

    urls_json.each do |song_json|
      song_url = search "#{song_json["name"].strip}-#{song_json["artist"].split("\n").first.strip}"
      download_url = obtain_song_url song_url
      @playlist_urls <<   {filename: "#{song_json["name"].strip}",url: download_url}
      pbar.inc
    end
    pbar.finish
  end

  def download  urls = @playlist_urls
    headers = {
        "Host" => "www.goear.com",
        "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:37.0) Gecko/20100101 Firefox/37.0",
        "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "Accept-Language" => "es-ES,es;q=0.8,en-US;q=0.5,en;q=0.3",
        "DNT" => "1",
        "Content-Type" => "text/html",
        "Connection" => "keep-alive",
        "Cookie" => "visitor_country=Spain; _gauges_unique_day=1; _gauges_unique_month=1; _gauges_unique_year=1; _gauges_unique=1;" + @cookies
      }
    urls.each do |elements|
      puts "downloading #{elements[:filename]}"
      downloaded_file = File.open  elements[:filename]+".mp3", 'wb'
      request = Typhoeus.get  elements[:url], followlocation: true, headers: headers, params: nil
      downloaded_file.write(request.body)
      downloaded_file.close
    end
  end

  def open_playlist_file
    File.open("playlist.json","rb") do |file|
      @playlist_json = JSON.parse(file.read)
    end
  end
end

cli = Goearify.new
cli.open_playlist_file
cli.login
cli.obtain_urls
cli.download
