require 'csv'
require 'ostruct'
require 'date'

def checkForFile()
  films = ARGV.first || 'movies.txt' 
  arrayWithFilms = []
  CSV.foreach(films, {:col_sep => '|'}) do |row|
    arrayWithFilms<< doArrayWithHash(row)
    end
    arrayWithFilms
end


def doArrayWithHash(row)
  {
    url: row[0],
    name: row[1],
    year: row[2].to_i,
    country: row[3],
    createdDate: anyStringToDate(row[4]),
    genre: row[5],
    timing: row[6].to_i,
    rating: ratingInStars(row[7].to_f),
    producer: row[8],
    actors: row[9]
  }
end

def anyStringToDate(row)
  if row.length == 10
    Date.parse(row)
  elsif row.length == 7
    row += '-01'
    Date.parse(row)
  else
    row += '-01-01'  #change in next time
    Date.parse(row)
  end
end

def sortByCreatedDate(films)
  allMonths = []
  sumOfMonths = Hash.new(0)
  films.each do |film|
    month = Date::MONTHNAMES[film[:createdDate].mon]
    sumOfMonths[month] += 1
  end
  sumOfMonths
end

def findFilmsWithMax(films)
  films.select do |movie| 
    movie[:name].include? 'Max'
  end
end

def ratingInStars(floatRating)
  string = '*'
  string *= (floatRating - 8) * 10
end

def printNameAndRating(findFilmsWithMax)
  findFilmsWithMax.each do |film|
    "#{film[:name]}: #{film[:rating]}"
  end
end

def filmTiming(films)
  arrayWithFiveLongestFilms = []
  arrayWithFiveLongestFilms << films.max_by(5) do |movie|
    movie[:timing]
  end
  printAllInfoAboutFilm(arrayWithFiveLongestFilms)
end

def filmDate(films)
  comedyFilms = []
  comedyFilms << films.select do |movie|
    movie[:genre].include? 'Comedy'
  end
  arrayWithTenFirstComedy = []
  comedyFilms.each do |sudenlyArray|
   arrayWithTenFirstComedy << sudenlyArray.min_by(10) do |film|
    film[:createdDate]
   end
  end
  printAllInfoAboutFilm(arrayWithTenFirstComedy)
end

def filmCountry(films)
  needFilms = []
  films.each do |movie|
    if movie[:country].include?('USA') == false
      needFilms << movie
    end
  end
  needFilms.length
end

def producersList(films)
  films.map { |film| film[:producer] }
       .uniq
       .sort_by { |s| s.scan(/\w+$/) }
end

def printAllInfoAboutFilm(arrayWithNeedFilms)
  arrayWithNeedFilms.each do |movie|
    movie.each do |film|
      "#{film[:name]} (#{film[:createdDate]}; #{film[:genre]}) - #{film[:timing]} min"
    end
  end
end

films = checkForFile()
filmsWithMax = findFilmsWithMax(films)
printNameAndRating(filmsWithMax)
filmCountry(films)
filmTiming(films)
filmDate(films)
producersList(films)
sortByCreatedDate(films)