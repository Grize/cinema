require './MovieCollection.rb'
require './Movie.rb'
require 'pry'
require './movieTypes.rb'
class Theater < MoviesCollection
  TIMENOW = Time.now
  MOVIE_TIME = {Range.new(7,12) => :ancient,
                Range.new(12,17) => :moder,
                Range.new(18,23) => :new }.freeze
  def initialize
    super
  end
  def show(time)
    
  end
end
