def fileSelectAndTakeContent(fileName)
  films = []
  if ARGV.empty?
    File.open('movies.txt') do |content|
      content.each do |line|
        films << line
      end
    end
  else
    ARGV.each do |fileName|
      if File.exist?(fileName)
        File.open(fileName) do |content|
          content.each do |line|
            films << line
          end
        end
      elsif File.exist?(fileName) == false
        puts "Achtung! #{fileName} don't exist!"
      else 
        puts "I don't know what you did, but you destroy everything!"
      end
    end
  end
films
end

def filmsWithHash(films)
  hashFilms = []
  films.each do |line|
    splitLine = line.split('|')
    filmInfo = Hash.new
    filmInfo["url"] = splitLine[0]
    filmInfo['name'] = splitLine[1]
    filmInfo['year'] = splitLine[2].to_i
    filmInfo['country'] = splitLine[3]
    filmInfo['crearedAdd'] = splitLine[4].to_i
    filmInfo['genre'] = splitLine[5]
    filmInfo['timing'] = splitLine[6].to_i
    filmInfo['rating'] = ratingInStars(splitLine[7].to_f)
    filmInfo['producer'] = splitLine[8]
    filmInfo['actors'] = splitLine[9]
    hashFilms << filmInfo
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

films = fileSelectAndTakeContent(ARGV.first)
hashFilms = filmsWithHash(films)
filmsWithMax = findFilmsWithMax(hashFilms)
printNameAndRating(filmsWithMax)
