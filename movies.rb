def checkForFile(filmName)
  films =[]
  if ARGV.empty?
    File.open('movies.txt') do |content|
      content.each do |line|
        films << line
      end
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
      File.open(fileName) do |content|
        content.each do |line|
          films << line 
        end
      end
    else
      puts "Warning! #{fileName} don't exist!"
    end
  end
  films
end

def filmsWithHash(films)
  hashFilms = []
  films.each do |line|
    splitLine = line.split('|')
    film = Hash.new
    film["url"] = splitLine[0]
    film['name'] = splitLine[1]
    film['year'] = splitLine[2].to_i
    film['country'] = splitLine[3]
    film['createdDate'] = splitLine[4].to_i
    film['genre'] = splitLine[5]
    film['timing'] = splitLine[6].to_i
    film['rating'] = ratingInStars(splitLine[7].to_f)
    film['producer'] = splitLine[8]
    film['actors'] = splitLine[9]
    hashFilms << film
  end
  hashFilms
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
    puts "#{film.values_at('name').to_s.delete('[]""')}: #{film.values_at('rating').to_s.delete('""[]')}"
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
  puts needFilms.length
end

def producersList(film)
  producerList = []
  film.each do |movie|
   producerList << movie.values_at('producer')
  end
  puts producerList.uniq.sort_by {|s| s.to_s.delete('""[]').scan(/\w+$/)}
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
  puts resultArrayWithFiveLongestFilm
  puts resultArrayWithComedy
end

films = checkForFile(ARGV.first)
hashFilms = filmsWithHash(films)
filmsWithMax = findFilmsWithMax(hashFilms)
printNameAndRating(filmsWithMax)
filmCountry(hashFilms)
producersList(hashFilms)
printAllInfoAboutFilm(filmTiming(hashFilms), filmDate(hashFilms))