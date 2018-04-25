require 'csv'
require 'ostruct'
require 'date'
require './MovieCollection.rb'


collection = MoviesCollection.new
def sortByCreatedDate(collection)
  puts collection.stats(:month)
end

def findFilmsWithMax(collection)
  collection.all.select do |movie| 
    movie.toHash[:name].include? 'Max'
  end
end

def printNameAndRating(findFilmsWithMax)
  findFilmsWithMax.each do |film|
    "#{film.toHash[:name]}: #{film.toHash[:rating]}"
  end
end

def filmTiming(collection)
  arrayWithFiveLongestFilms = []
  arrayWithFiveLongestFilms << collection.all.max_by(5) do |movie|
    movie.toHash[:timing]
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
    film.toHash[:createdDate]
   end
  end
  printAllInfoAboutFilm(arrayWithTenFirstComedy)
end

def filmCountry(collection)
  needFilms = []
  collection.all.each do |movie|
    if movie.toHash[:country].include?('USA') == false
      needFilms << movie
    end
  end
  needFilms.length
end

def producersList(collection)
  collection.all.map { |film| film.toHash[:producer] }
       .uniq
       .sort_by { |s| s.scan(/\w+$/) }
end

def printAllInfoAboutFilm(arrayWithNeedFilms)
  arrayWithNeedFilms.each do |movie|
    movie.each do |film|
      "#{film.toHash[:name]} (#{film.toHash[:createdDate]}; #{film.toHash[:genre]}) - #{film.toHash[:timing]} min"
    end
  end
end

#films = checkForFile(ARGV.first)
filmsWithMax = findFilmsWithMax(collection)
printNameAndRating(filmsWithMax)
filmCountry(collection)
filmTiming(collection)
filmDate(collection)
producersList(collection)
sortByCreatedDate(collection)