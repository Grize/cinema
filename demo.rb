require 'csv'
require 'ostruct'
require 'date'
require_relative 'movie.rb'
require_relative 'movie_collection.rb'
require_relative 'netflix.rb'
require_relative 'theater.rb'

file = ARGV.first || 'movies.txt'
unless File.exist?(file)
  puts "File not found"
  exit
end

collection = MovieCollection.new(file)

def sortByCreatedDate(collection)
  collection.stats(:month)
end

def findFilmsWithMax(collection)
  collection.all.select do |movie| 
    movie.send(:name).include? 'Max'
  end
end

def printNameAndRating(findFilmsWithMax)
  findFilmsWithMax.each do |film|
    "#{film.send(:name)}: #{film.send(:rating)}"
  end
end

def filmTiming(collection)
  arrayWithFiveLongestFilms = []
  arrayWithFiveLongestFilms << collection.all.max_by(5) do |movie|
    movie.send(:timing)
  end
  printAllInfoAboutFilm(arrayWithFiveLongestFilms)
end

def filmDate(collection)
  comedyFilms = []
  comedyFilms << collection.all.select do |movie|
    movie.has_genre?('Comedy')
  end
  arrayWithTenFirstComedy = []
  comedyFilms.each do |sudenlyArray|
    arrayWithTenFirstComedy << sudenlyArray.min_by(10) do |film|
    film.send(:createdDate)
   end
  end
  printAllInfoAboutFilm(arrayWithTenFirstComedy)
end

def filmCountry(collection)
  needFilms = []
  collection.all.each do |movie|
    if movie.send(:country).include?('USA') == false
      needFilms << movie
    end
  end
  needFilms.length
end

def producersList(collection)
  collection.all.map { |film| film.send(:producer) }
       .uniq
       .sort_by { |s| s.scan(/\w+$/) }
end

def printAllInfoAboutFilm(arrayWithNeedFilms)
  arrayWithNeedFilms.each do |movie|
    movie.each do |film|
      "#{film.send(:name)} (#{film.send(:createdDate)}; #{film.send(:genre)}) - #{film.send(:timing)} min"
    end
  end
end

filmsWithMax = findFilmsWithMax(collection)
printNameAndRating(filmsWithMax)
filmCountry(collection)
filmTiming(collection)
filmDate(collection)
producersList(collection)
sortByCreatedDate(collection)