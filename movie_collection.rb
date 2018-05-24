require 'csv'

class MovieCollection
  
  attr_reader  :genre
  
  def initialize(file)
    @movies = CSV.read(file, col_sep: '|')
                 .map { |movie| Movie.create(movie, self)}
  end
  
  def all
    @movies
  end

  def collect_values(arg)
    @movies.flat_map(&arg)
  end

  def genre_exist?(genre)
    collect_values(:genre).uniq
                          .include? genre
  end
  
  def sort_by(neededPosition)
    raise ArgumentError, 'Wrong argument' unless @movies.first.respond_to?(neededPosition)
    @movies.sort_by {|movie| movie.send(neededPosition)}
  end
  
  def filter(neededPosition, word)
    @movies.select do |movie|
      movie.send(neededPosition).include? word
    end
  end
  
  def stats(neededPosition)
    @movies.flat_map(&neededPosition).compact.each_with_object(Hash.new(0)) { |count, genre| genre[count] += 1}
  end

end

