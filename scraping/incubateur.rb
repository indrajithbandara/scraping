require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require 'csv'
require 'pry'

PAGE_URL = "http://www.helioparc.com/fr/residents"

page = Nokogiri::HTML(open(PAGE_URL)) # Building Nokogiri Object to scrape with open-uri the PAGE_URL constant and storing Object in variable 

links = page.css("a")

links.each do |link|
  p link['href']
end
