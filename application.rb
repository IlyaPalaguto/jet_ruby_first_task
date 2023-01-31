require_relative 'distance_service'
require 'singleton'

class Application
  include Singleton
  
  def call
    puts 'Type weight, please'
    @weight = gets.strip.to_i
    puts 'Type height, please'
    @height = gets.strip.to_i
    puts 'Type lenght, please'
    @lenght = gets.strip.to_i
    puts 'Type width please'
    @width = gets.strip.to_i

    @size = calculate_size(@width, @height, @lenght)

    puts 'Type starting point, please'
    @starting_point = gets.strip

    puts 'Type destination, please'
    @destination = gets.strip

    @distance = calculate_distance(@starting_point, @destination)

    @price = calculate_price(@size, @weight, @distance)

    {
      weight: @weight,
      lenght: @lenght,
      width: @width,
      height: @height,
      distance: @distance.km,
      price: @price
    }

  rescue
    puts 'No route matches'
  end

  private

  def calculate_size(*dimensions)
    dimensions.map! { |scale| scale * 0.01}
    dimensions[0] * dimensions[1] * dimensions[2]
  end

  def calculate_price(size, weight, distance)
    if size >= 1
      if weight < 10
        distance.km * 2
      else
        distance.km * 3
      end
    else
      distance.km * 1
    end
  end

  def calculate_distance(starting_point, destination)
    DistanceService.new(starting_point: starting_point, destination: destination).call
  end
end
