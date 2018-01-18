# Tuto http://ruby.bastardsbook.com/chapters/html-parsing/
require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require 'restclient'

# PAGE_URL = "http://ruby.bastardsbook.com/files/hello-webpage.html"

# page = Nokogiri::HTML(RestClient.get(PAGE_URL))

# puts page.class   # => Nokogiri::HTML::Document

# page = Nokogiri::HTML(open("index.html"))   
# puts page.class   # => Nokogiri::HTML::Document

# page = Nokogiri::HTML(open("https://en.wikipedia.org/"))   
# puts page.class   # => Nokogiri::HTML::Document

# page = Nokogiri::HTML(RestClient.get("https://en.wikipedia.org/"))   
# puts page.class   # => Nokogiri::HTML::Document

# puts page.css("title")[0].name   # => returns the class name title 
# puts page.css("title")[0].text   # => returns whats in the class name title My webpage

#####################################################################################

# links = page.css("a")

# puts links.length   # => 7
# puts links[0].text   # => Click here
# puts links[0]["href"] # => http://www.google.com

# links.map.with_index do |link, i|
#   puts "Link number #{i} => #{link.text} => #{link["href"]}"
# end

# puts "Total links #{links.length}"

# or more specific here 

# page = Nokogiri::HTML(open(PAGE_URL))
         
# news_links = page.css("div#references a")
# news_links.each{|link| puts "#{link.text}\t#{link['href']}"}     

######################################################################################

# news_links = page.css("a").select{|link| link['data-category'] == "news"}
# news_links.each{|link| puts link['href'] }

#=>   http://reddit.com
#=>   http://www.nytimes.com
         
# puts news_links.class   #=>   Array   

#######################################################################################

# news_links = page.css("a[data-category=news]")
# news_links.each{|link| puts link['href']}
# #=>   http://reddit.com
# #=>   http://www.nytimes.com

# puts news_links.class   #=>   Nokogiri::XML::NodeSet 

#######################################################################################

# page = Nokogiri::HTML(open('http://en.wikipedia.org/wiki/HTML'))
# page.css('div#content div#bodyContent table.infobox tr th').each do |el|
#    puts el.text
# end

#######################################################################################

# Find all "a" tags with a parent tag whose name is "h3"

# doc = Nokogiri::HTML(open("http://www.google.com/search?q=doughnuts"))
# 	doc.xpath('//h3/a').each do |node|
# 	  puts node.text
# 	end

# To match “h3” tags that have a class attribute, we write:

# 	h3[@class]

# To match “h3” tags whose class attribute is equal to the string “r”, we write:

# 	h3[@class = "r"]

# Using the attribute matching construct, we can modify our previous query to:

# 	//h3[@class = "r"]/a[@class = "l"]

# which in English terms is:

# Find all "a" tags with a class attribute equal to "l" and an immediate parent tag "h3" that has a class attribute equal to "r"


########################################################################################


   
