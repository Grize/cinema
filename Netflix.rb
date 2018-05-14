require './MovieCollection.rb'
require './Movie.rb'
require 'pry'
require './movieTypes.rb'
require 'date'
class Netflix < MoviesCollection
  TIMENOW = Time.now
  @@money = 0
  MOVIES_TYPES = { ancient: 1900..1945,
                   classic: 1946..1968,
                   modern: 1969..2000,
                   new: 2001..3000}.freeze                
  def initialize
    super
  end
  def pay(money)
    #binding.pry
    @@money += money
  end
  def how_much?(name)
    neededMovies = []
    neededMovies.concat(@movies.select{ |movie| movie.send(:name).include? name})
    neededMovies.first.class::COST
  end
  def show(neededPosition, period)
    #binding.pry
    neededMovies = []
    neededMovies.concat(@movies.select { |movie| movie.has_genre?(neededPosition) && MOVIES_TYPES[period] === movie.send(:year) })
    @@money -= neededMovies.first.class::COST
    if @@money < neededMovies.first.class::COST
      raise "You don't have money"
    end
    puts "Now showing: #{neededMovies.first.name}, time start: #{TIMENOW.strftime("%H:%M:%S")} - time end: #{(TIMENOW + (neededMovies.first.timing * 60)).strftime("%H:%M:%S")} "
  end
end
