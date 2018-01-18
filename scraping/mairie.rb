require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require 'csv'
# require 'restclient'
# require 'pry'

# puts "Please enter your municipalities url"

# PAGE_URL = gets.chomp.to_s

# Here we put the page url as a constant you can also get and pass user input
PAGE_URL = "http://annuaire-des-mairies.com/val-d-oise.html"

# Declare an empty array we need it to store the hash obtained later
TABLE = []

def get_all_the_urls_of_val_doise_townhalls

  begin # Begin error checking
  
  page = Nokogiri::HTML(open(PAGE_URL)) # Building Nokogiri Object to scrape with open-uri the PAGE_URL constant and storing Object in variable 
  
  # On the page object we call the .css method, the argument is for the selector .lientxt class  
  links = page.css(".lientxt") # We get back all selected elements (array or hash ?) and put them in links variable

  # On links we call the each method so for each link we call the get_the_email_of_a_townhal_from_its_webpage(link['href'])
  links.each do |link|
    get_the_email_of_a_townhal_from_its_webpage(link['href'])
  end 

  CSV.open("data_mairies_email.csv", "wb") do |csv|
    csv << TABLE.first.keys # adds the attributes name on the first line
    TABLE.each do |hash|
      csv << hash.values
    end
  end
  puts "============================================================================================="
  puts "The list of email addresses of the townhalls has been put in a csv file data_mairie_email.csv"

  rescue => e
    puts "Exception Class: #{ e.class.name }"
    puts "Exception Message: #{ e.message }"
    puts "Exception Backtrace: #{ e.backtrace }"
  end
  
end

def get_the_email_of_a_townhal_from_its_webpage(url)

  begin
    
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/" + url)) 
    
  elements = page.css('td p font')
    
  city = page.css(".lientitre")

  city_name = city[0].text
    
  elements.each do |el| 
    if el.text.include?('@')
      TABLE << {:ville => city_name.downcase.capitalize, :email => el.text}
      puts "#{city_name.downcase.capitalize} Contact: #{el.text}"
    end
  end        

  rescue => e
    puts "Exception Class: #{ e.class.name }"
    puts "Exception Message: #{ e.message }"
    puts "Exception Backtrace: #{ e.backtrace }"
  end
   
end

get_all_the_urls_of_val_doise_townhalls


