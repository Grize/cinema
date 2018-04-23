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
  def sort_by(stat)
    @movies.sort_by {|movie| movie.toHash[stat]}
  end
  def filter(stat, word)
    @movies.select do |movie|
      movie.toHash[stat].include? word
    end
  end
  def stats(stat)
    statistic = Hash.new(0)
    @movies.each do |movie|
      if stat == :month
        month = Date::MONTHNAMES[movie.toHash[:createdDate].mon]
        statistic[month] += 1
      elsif stat == :actors || stat == :genre
        array = movie.toHash[stat].split(',').first.to_s
        statistic[array] += 1
      else
        thing = movie.toHash[stat]
        statistic[thing] += 1
      end
    end
    statistic
  end
end

