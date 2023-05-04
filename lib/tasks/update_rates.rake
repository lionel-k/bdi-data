require 'open-uri'
require 'nokogiri'

desc 'Add latest rate from BRB website'
task :update_rates do
  html_content = open('https://brb.bi/').read
  doc = Nokogiri.HTML(html_content)

  exchange_rate = ExchangeRate.find_or_create_by(date: Date.today)
  exchange_rate.currencies.destroy_all

  table = doc.search('.views-table')
  rows = table.xpath('//table/tbody/tr')
  rates =
    rows.map do |row|
      columns = row.xpath('td')
      name = columns[0].text.strip
      buyer = columns[1].text.strip.to_f
      seller = columns[2].text.strip.to_f
      rate = ((buyer + seller) / 2).round(2)
      { name: name, buyer: buyer, seller: seller, rate: rate }
    end
  exchange_rate.currencies.create!(rates)
end
