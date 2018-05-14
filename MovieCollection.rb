require './Movie.rb'
require 'csv'

class MoviesCollection
  def initialize
    @movies = []
    films = ARGV.first || 'movies.txt'
    CSV.foreach(films, {:col_sep => '|'}) do |row|
      if row[2].to_i <= 1945
        movie = AncientMovie.new(row)
        @movies << movie
      elsif row[2].to_i >= 1945 && row[2].to_i <= 1968
        movie = ClassicMovie.new(row)
        @movies << movie
      elsif row[2].to_i >= 1968 && row[2].to_i <= 2000
        movie = ModernMovie.new(row)
        @movies << movie
      else 
        movie = NewMovie.new(row)
        @movies << movie
      end
    end
  end
  def all
    moviesCollection = []
    @movies.each do |movie|
      moviesCollection << movie
    end
    moviesCollection
  end
  def sort_by(neededPosition)
    @movies.sort_by {|movie| movie.send(neededPosition)}
  end
  def filter(neededPosition, word)
    @movies.select do |movie|
      movie.send(neededPosition).include? word
    end
  end
  def stats(neededPosition)
    statistic = Hash.new(0)
    @movies.each do |movie|
      if neededPosition == :month
        month = Date::MONTHNAMES[movie.send(:createdDate).mon]
        statistic[month] += 1
      elsif neededPosition == :actors || neededPosition == :genre
        array = movie.send(neededPosition).split(',').first.to_s
        statistic[array] += 1
      else
        thing = movie.send(neededPosition)
        statistic[thing] += 1
      end
    end
    statistic
  end
end

