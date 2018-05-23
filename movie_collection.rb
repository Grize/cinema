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

