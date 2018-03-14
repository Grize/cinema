require 'csv'
require 'ostruct'
require 'date'

def checkForFile(filmName)
  films = []
  if ARGV.empty?
    CSV.foreach('movies.txt', {:col_sep => '|'}) do |row|
      films << doArrayWithOpenStr(row)
    end
  else 
    checkForExist(ARGV.first)
  end
  films
end

def checkForExist(fileName)
  films = []
  ARGV.each do |fileName|
    if File.exist?(fileName)
      CSV.foreach("#{fileName}", {:col_sep => '|'}) do |row|
        films << doArrayWithOpenStr(row)
      end
    else
      puts "Warning! #{fileName} don't exist!"
    end
  end
  films
end

def doArrayWithOpenStr(row)
  films = []
  film = Hash.new
    film["url"] = row[0]
    film['name'] = row[1]
    film['year'] = row[2].to_i
    film['country'] = row[3]
    film['createdDate'] = anyStringToDate(row[4])
    film['genre'] = row[5]
    film['timing'] = row[6].to_i
    film['rating'] = row[7]
    film['producer'] = row[8]
    film['actors'] = row[9]
    films << OpenStruct.new(film)
  films
end

def anyStringToDate(row)
  if row.length == 10
    Date.parse(row)
  elsif row.length == 7
    row += '-01'
    Date.parse(row)
  else
    row += '-01-01'
    Date.parse(row)
  end
end

def findFilmsWithMax(hashFilms)
  hashFilms.select do |movie| 
    movie.values_at('name').any?{|string| string.include? 'Max'}
  end
end

def ratingInStars(floatRating)
  string = '*'
  string *= (floatRating - 8) * 10
end

def printNameAndRating(findFilmsWithMax)
  findFilmsWithMax.each do |film|
    "#{film.values_at('name').to_s.delete('[]""')}: #{film.values_at('rating').to_s.delete('""[]')}"
  end
end

def filmTiming(film)
  arrayWithFiveLongestFilms = []
  arrayWithFiveLongestFilms << film.max_by(5) do |movie|
    movie.values_at('timing').to_s.delete('[]""min').to_i
  end
  arrayWithFiveLongestFilms
end

def filmDate(film)
  comedyFilms = []
  comedyFilms << film.select do |movie|
    movie.values_at('genre').any? {|word| word.include? 'Comedy'}
  end
  arrayWithTenFirstComedy = []
  comedyFilms.each do |sudenlyArray|
   arrayWithTenFirstComedy << sudenlyArray.min_by(10) do |film|
    film.values_at('createdDate')
   end
  end
  arrayWithTenFirstComedy
end

def filmCountry(film)
  needFilms = []
  film.each do |movie|
    if movie.value?("USA") == false
      needFilms << movie
    else
    end
  end
  needFilms.length
end

def producersList(film)
  producerList = []
  film.each do |movie|
   producerList << movie.values_at('producer')
  end
  producerList.uniq.sort_by {|s| s.to_s.delete('""[]').scan(/\w+$/)}
end

def printAllInfoAboutFilm(filmTime,filmDate)
  resultArrayWithFiveLongestFilm = []
  resultArrayWithComedy = []
  filmTime.each do |movie|
    movie.each do |v|
      resultArrayWithFiveLongestFilm << "#{v.values_at('name')} (#{v.values_at('createdDate')}; #{v.values_at('genre')}) - #{v.values_at('timing')}".delete('""[]')
    end
  end
  filmDate.each do |movie|
    movie.each do |v|
      resultArrayWithComedy << "#{v.values_at('name')} (#{v.values_at('createdDate')}; #{v.values_at('genre')}) - #{v.values_at('timing')}".delete('""[]')
    end
  end
  resultArrayWithFiveLongestFilm
  resultArrayWithComedy
end

films = checkForFile(ARGV.first)
filmsWithMax = findFilmsWithMax(hashFilms)
printNameAndRating(filmsWithMax)
filmCountry(hashFilms)
producersList(hashFilms)
printAllInfoAboutFilm(filmTiming(hashFilms), filmDate(hashFilms))