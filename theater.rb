require_relative 'movie_collection.rb'

require 'pry'

class Theater < MovieCollection
  
  def show(time)
    neededFilms = []
    if (8...12).include?(time)
      neededFilms.concat(@movies.select { |movie| movie.is_a?(AncientMovie) })
    elsif (12...16).include?(time)
      neededFilms.concat(@movies.select { |movie| movie.has_genre?('Comedy')})
      neededFilms.concat(@movies.select { |movie| movie.has_genre?('Adventure')})
    else
      neededFilms.concat(@movies.select { |movie| movie.has_genre?('Drama')})
      neededFilms.concat(@movies.select { |movie| movie.has_genre?('Horror')})
    end
    puts neededFilms
  end
  
  def when?(name)
    neededFilm = []
    neededFilm.concat(@movies.select { |movie| movie.name.include? name})
    case neededFilm.first
    when AncientMovie
      puts 'from 7 to 12'
    else 
      if neededFilm.first.has_genre?('Comedy') || neededFilm.first.has_genre?('Adventure')
        puts 'from 12 to 16'
      elsif neededFilm.first.has_genre?('Drama') || neededFilm.first.has_genre?('Horror')
        puts 'from 16 to 23'
      end
    end
  end

end
