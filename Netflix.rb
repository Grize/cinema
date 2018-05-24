require_relative 'movie_collection.rb'

require 'pry'
require 'date'
require 'pickup'

class Netflix < MovieCollection
  TIMENOW = Time.now            
  
  MOVIE_TYPES = {:ancient => AncientMovie,
                 :classic => ClassicMovie,
                 :modern => ModernMovie,
                 :new => NewMovie}.freeze

  attr_reader :money

  def initialize(file)
    super
    @money = 0
  end
  
  def pay(money)
    #binding.pry
    @money += money
  end
  
  def how_much?(name)
    neededMovies = []
    neededMovies.concat(@movies.select{ |movie| movie.send(:name).include? name})
    neededMovies.first.class::COST
  end
  
  def show(neededPosition, period)
    #binding.pry
    neededMovie = @movies.select { |movie| movie.has_genre?(neededPosition) && MOVIE_TYPES[period] == movie.class }.sample
    @money -= neededMovie.class::COST
    if @money < neededMovie.class::COST
      raise "You don't have money"
    end
    puts "Now showing: #{neededMovie.name}, time start: #{TIMENOW.strftime("%H:%M:%S")} - time end: #{(TIMENOW + (neededMovie.timing * 60)).strftime("%H:%M:%S")} "
  end

end
