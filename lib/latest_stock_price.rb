require 'net/http'
require 'json'

class LatestStockPrice
  BASE_URL = 'https://latest-stock-price.p.rapidapi.com'


  # 303f6151c6msh835d4ebe8f02697p15f620jsn786d23c973f0
  def initialize()
    @headers = {
      'X-RapidAPI-Key' => "303f6151c6msh835d4ebe8f02697p15f620jsn786d23c973f0",
      'X-RapidAPI-Host' => 'latest-stock-price.p.rapidapi.com'
    }
  end

  def price(symbol)
    request('/price', symbol: symbol)
  end

  def prices(symbols)
    request('/prices', symbols: symbols.join(','))
  end

  def price_all
    request('/price_all')
  end

  private

  def request(endpoint, params = {})
    uri = URI("#{BASE_URL}#{endpoint}")
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri, @headers)

    raise "Request failed: #{response.message}" unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  end
  
end