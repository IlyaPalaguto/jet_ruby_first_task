require_relative 'distance_matrix_client'

class DistanceService
  def initialize(starting_point:, destination:, client: default_client)
    @client = client
    @destination = destination
    @starting_point = starting_point
  end

  Distance = Struct.new(:args) do
    def meters
      JSON.parse(args[:response].body)['rows'][0]['elements'][0]['distance']['value']
    end

    def km
      meters / 1000
    end
  end

  def call
    response = @client.calculate(destination: @destination, origin: @starting_point)
    
    if JSON.parse(response.body)["rows"][0]["elements"][0]["status"] == 'OK'
      Distance.new(response: response)
    else
      raise JSON.parse(response.body)["rows"][0]["elements"][0]["status"]
    end
  end

  private
  
  def default_client
    DistanceMatrixClient.new
  end
end
