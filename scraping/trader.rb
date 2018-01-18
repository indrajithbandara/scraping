require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require 'csv'
require 'pry'

# currency-name-container 
# price

# Here we put the page url as a constant you can also get and pass user input
PAGE_URL = "https://coinmarketcap.com/all/views/all/"

# Declare an empty array we need it to store the hash obtained later
CRYPTO_NAME = []
CRYPTO_PRICE = []
TABLE = []

def trader_de_l_obscur

  begin # Begin error checking
  
  h = Hash.new

  page = Nokogiri::HTML(open(PAGE_URL)) # Building Nokogiri Object to scrape with open-uri the PAGE_URL constant and storing Object in variable 

  # On the page object we call the .css method, the argument is for the selector .lientxt class  
  crypto_currencies = page.css(".currency-name-container") # We get back all selected elements (array or hash ?) and put them in links variable
  crypto_values = page.css(".price") # We get back all selected elements (array or hash ?) and put them in links variable
  
  crypto_currencies.each do |crypto_currency|
    CRYPTO_NAME << crypto_currency.text
  end

  crypto_values.each do |crypto_value|
    CRYPTO_PRICE << crypto_value.text
  end

  for i in (0..CRYPTO_NAME.length-1)
    h[CRYPTO_NAME[i]] = CRYPTO_NAME[i] + ' ' + CRYPTO_PRICE[i]
    TABLE << h
    h = {}
  end
  #binding.pry
  CSV.open("crypto_currencies.csv", "wb") do |csv|
    csv << TABLE.first.keys # adds the attributes name on the first line
    TABLE.each do |hash|
      csv << hash.values
    end
  end

  puts "============================================================================================="
  puts "The bitcoin values has been put in a csv file crypto_currencies.csv"
  rescue => e
    puts "Exception Class: #{ e.class.name }"
    puts "Exception Message: #{ e.message }"
    puts "Exception Backtrace: #{ e.backtrace }"
  end

end

trader_de_l_obscur