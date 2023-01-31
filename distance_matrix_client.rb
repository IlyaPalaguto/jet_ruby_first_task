require 'faraday'

class DistanceMatrixClient
  
  ROOT_ENDPOINT = "https://api.distancematrix.ai/maps/api/distancematrix/json"
  ACCESS_TOKEN = 'distance-matrix.ai'
  

  def initialize
    @http_client = setup_http_client
  end

  def calculate(destination:, origin:)
    @http_client.get do |request|
      request.params[:destinations] = destination
      request.params[:origins]      = origin
      request.params[:key]          = ACCESS_TOKEN
    end
  end

  private

  def setup_http_client
    Faraday.new(url: ROOT_ENDPOINT)
  end
end