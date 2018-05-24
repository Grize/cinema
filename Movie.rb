class Movie
  
  require_relative 'ancient_movie.rb'
  require_relative 'classic_movie.rb'
  require_relative 'modern_movie.rb'
  require_relative 'new_movie.rb'
  
  attr_reader :url, :name, :year, :country, :createdDate, :genre, :timing, :rating, :producer, :actors

  MOVIE_CLASS = {
    1900..1945 => AncientMovie,
    1945..1968 => ClassicMovie,
    1968..2000 => ModernMovie,
    2000..3000 => NewMovie
  }.freeze

  def initialize(movie, movie_collection)
    @url = movie[0]
    @name = movie[1]
    @year = movie[2]
    @country = movie[3]
    @createdDate = movie[4]
    @genre = movie[5].split(',')
    @timing = movie[6].to_i
    @rating = ratingInStars(movie[7].to_f)
    @producer = movie[8]
    @actors = movie[9].split(',')
    @movie_collection = movie_collection
  end
  
  def has_genre?(genre) 
    raise ArgumentError, "Don't found #{genre}" unless @movie_collection.genre_exist? genre
    self.genre.include? genre
  end

  def period()
    self.class.name
  end

  def self.create(movie, movie_collection)
    _, movie_class = MOVIE_CLASS.detect { |year, period| year.cover?(movie[2].to_i) }

    raise ArgumentError, "Imposible to recognize period" unless movie_class

    movie_class.new(movie, movie_collection)
  
  end

  private
  
  def ratingInStars(floatRating)
    string = '*'
    string *= (floatRating - 8) * 10
  end

end
