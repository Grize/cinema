require './Movie.rb'
require 'date'
require 'pry'

class AncientMovie < Movie
  COST = 1
  def to_s
    "#{@name} - ancient film (#{@year})"
  end
end
class ClassicMovie < Movie
  COST = 1.5
  def to_s
    "#{@name} - classic film, #{@producer}"
  end
end
class ModernMovie < Movie
  COST = 3
  def to_s
    "#{@name} - modern film: #{@actors}"
  end
end
class NewMovie < Movie
  COST = 5
  TODAY = Date.today
  def to_s
    #binding.pry
    "#{@name} - new film,created #{ TODAY.year - @createdDate.year } years ago"
  end
end 