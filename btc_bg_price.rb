#!/usr/bin/ruby
# encoding: UTF-8

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mysql'

##### Crypto.bg #####

begin
		exchange = "https://crypto.bg/"
		page_crypto_bg = Nokogiri::HTML(open(exchange))
		
		buy_price_crypto_bg = page_crypto_bg.css("tr.bitcoin td.left").text.strip
		sell_price_crypto_bg = page_crypto_bg.css("tr.bitcoin td.right").text.strip
		
		print "Crypto.bg: ", buy_price_crypto_bg, " ", sell_price_crypto_bg, "\n"

	rescue Exception
		print "Unable to obatain BTC prices from ", exchange, "!\n"

end


##### Bitcoini.com #####

begin
		exchange = "https://bitcoini.com/"
		page_bitcoini_com = Nokogiri::HTML(open(exchange + "login.php"))

		prices_bitcoini_com = page_bitcoini_com.css("div.nomobile span")

		buy_price_bitcoini_com = prices_bitcoini_com.at(0).text.strip
		sell_price_bitcoini_com = prices_bitcoini_com.at(1).text.strip

		print "Bitcoini.com: ", buy_price_bitcoini_com, " ", sell_price_bitcoini_com, "\n"

	rescue Exception
		print "Unable to obatain BTC prices from ", exchange, "!\n"

end

##### Coinfixer.com #####

begin
		exchange = "https://coinfixer.com/"
		page_coinfixer_com_sell = Nokogiri::HTML(open(exchange + "buy/?type=btcbuy"))
		page_coinfixer_com_buy = Nokogiri::HTML(open(exchange + "sell/?type=btcsell"))

		buy_price_coinfixer_com = page_coinfixer_com_buy.css("span.actual_price_cryptocoin_price").text.strip
		sell_price_coinfixer_com = page_coinfixer_com_sell.css("span.actual_price_cryptocoin_price").text.strip

		print "Coinfixer.com: ", buy_price_coinfixer_com, " ", sell_price_coinfixer_com, "\n"

	rescue Exception
		print "Unable to obatain BTC prices from ", exchange, "!\n"

end

##### Writing obtained data to a DB

begin
    con = Mysql.new '', '', ''
    puts con.get_server_info
    rs = con.query 'SELECT VERSION()'
    puts rs.fetch_row    
    
rescue Mysql::Error => e
    puts e.errno
    puts e.error
    
ensure
    con.close if con
end
