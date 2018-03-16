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
    films.concat(checkForExist(ARGV.first))
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
    film['rating'] = ratingInStars(row[7].to_f)
    film['producer'] = row[8]
    film['actors'] = row[9]
    OpenStruct.new(film)
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

def sortByCreatedDate(films)
  allMonth = []
  sumOfMonth = Hash.new(0)
  films.each do |film| 
    allMonth << film.createdDate.mon
  end
  allMonth.sort_by{|mon| mon}.each {|mon| sumOfMonth[mon] += 1}
  puts changeNameofKey(sumOfMonth).to_s.delete('{}:')
end

def changeNameofKey(sumOfMonth)
  sumOfMonth[:January] = sumOfMonth.delete(1)
  sumOfMonth[:February] = sumOfMonth.delete(2)
  sumOfMonth[:March] = sumOfMonth.delete(3)
  sumOfMonth[:April] = sumOfMonth.delete(4)
  sumOfMonth[:May] = sumOfMonth.delete(5)
  sumOfMonth[:June] = sumOfMonth.delete(6)
  sumOfMonth[:July] = sumOfMonth.delete(7)
  sumOfMonth[:August] = sumOfMonth.delete(8)
  sumOfMonth[:September] = sumOfMonth.delete(9)
  sumOfMonth[:October] = sumOfMonth.delete(10)
  sumOfMonth[:November] = sumOfMonth.delete(11)
  sumOfMonth[:December] = sumOfMonth.delete(12)
  sumOfMonth
end

def findFilmsWithMax(films)
  films.select do |movie| 
    movie.name.include? 'Max'
  end
end

def ratingInStars(floatRating)
  string = '*'
  string *= (floatRating - 8) * 10
end

def printNameAndRating(findFilmsWithMax)
  findFilmsWithMax.each do |film|
    "#{film.name}: #{film.rating}"
  end
end

def filmTiming(film)
  arrayWithFiveLongestFilms = []
  arrayWithFiveLongestFilms << film.max_by(5) do |movie|
    movie.timing
  end
  arrayWithFiveLongestFilms
end

def filmDate(film)
  comedyFilms = []
  comedyFilms << film.select do |movie|
    movie.genre.include? 'Comedy'
  end
  arrayWithTenFirstComedy = []
  comedyFilms.each do |sudenlyArray|
   arrayWithTenFirstComedy << sudenlyArray.min_by(10) do |film|
    film.createdDate
   end
  end
  arrayWithTenFirstComedy
end

def filmCountry(film)
  needFilms = []
  film.each do |movie|
    if movie.country.include?('USA') == false
      needFilms << movie
    else
    end
  end
  needFilms.length
end

def producersList(film)
  producerList = []
  film.each do |movie|
   producerList << movie.producer
  end
  producerList.uniq.sort_by {|s| s.scan(/\w+$/)}
end

def printAllInfoAboutFilm(filmTime,filmDate)
  resultArrayWithFiveLongestFilm = []
  resultArrayWithComedy = []
  filmTime.each do |movie|
    movie.each do |v|
      resultArrayWithFiveLongestFilm << "#{v.name} (#{v.createdDate}; #{v.genre}) - #{v.timing} min"
    end
  end
  filmDate.each do |movie|
    movie.each do |v|
      resultArrayWithComedy << "#{v.name} (#{v.createdDate}; #{v.genre}) - #{v.timing} min"
    end
  end
   resultArrayWithFiveLongestFilm
   resultArrayWithComedy
end

films = checkForFile(ARGV.first)
filmsWithMax = findFilmsWithMax(films)
printNameAndRating(filmsWithMax)
filmCountry(films)
producersList(films)
printAllInfoAboutFilm(filmTiming(films), filmDate(films))
sortByCreatedDate(films)