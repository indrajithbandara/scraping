require 'rubygems'
require 'nokogiri' 
require 'restclient'
require 'open-uri'
require 'pry'
require 'csv'

# puts "Please enter your municipalities url"

# PAGE_URL = gets.chomp.to_s

PAGE_URL = "http://annuaire-des-mairies.com/val-d-oise.html"
TABLE = []

def get_all_the_urls_of_val_doise_townhalls

    begin

    page = Nokogiri::HTML(open(PAGE_URL)) 
    links = page.css(".lientxt")
    links.each do |link|
        get_the_email_of_a_townhal_from_its_webpage(link['href'])
    end 

    CSV.open("data_mairies_email.csv", "wb") do |csv|
        csv << TABLE.first.keys # adds the attributes name on the first line
        TABLE.each do |hash|
          csv << hash.values
        end
     end

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
          TABLE << {:ville => city_name, :email => el.text}
      end
    end        

    rescue => e
        puts "Exception Class: #{ e.class.name }"
        puts "Exception Message: #{ e.message }"
        puts "Exception Backtrace: #{ e.backtrace }"
    end
   
  end


get_all_the_urls_of_val_doise_townhalls

