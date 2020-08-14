require 'open-uri'
require 'nokogiri'

html_content = open('brb.html').read
doc = Nokogiri::HTML(html_content)

table = doc.search('.views-table')
rows = table.xpath("//table/tbody/tr")
rates = rows.map do |row|
  columns = row.xpath('td')
  currency = columns[0].text.strip
  buyer = columns[1].text.strip.to_f
  seller = columns[2].text.strip.to_f
  rate = ((buyer + seller) / 2).round(2)
  { currency: currency, buyer: buyer, seller: seller, rate: rate }
end

p rates


rates
  date:
