require './Movie.rb'
require 'csv'

class MoviesCollection
  def initialize
    @movies = []
    films = ARGV.first || 'movies.txt'
    CSV.foreach(films, {:col_sep => '|'}) do |row|
      movie = Movie.new
      movie.url = row[0]
      movie.name = row[1]
      movie.year = row[2].to_i
      movie.country = row[3]
      movie.createdDate = anyStringToDate(row[4])
      movie.genre = row[5]
      movie.timing = row[6].to_i
      movie.rating = ratingInStars(row[7].to_f)
      movie.producer = row[8]
      movie.actors = row[9]
      @movies << movie
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

