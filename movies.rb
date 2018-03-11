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
    film['crearedAdd'] = splitLine[4].to_i
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

films = checkForFile(ARGV.first)
hashFilms = filmsWithHash(films)
filmsWithMax = findFilmsWithMax(hashFilms)
printNameAndRating(filmsWithMax)
