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

def findStrings(films)
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
    filmInfo['rating'] = splitLine[7].to_f
    filmInfo['producer'] = splitLine[8]
    filmInfo['actors'] = splitLine[9]
    hashFilms << filmInfo
  end
  hashFilms
end

def findMaxinFilm(hashFilms)
  hashFilms.select do |movie| 
    movie.values_at('name').any?{|string| string.include? 'Max'}
  end
end

def fromFloatToStar(filmsWithMax)
  films = []
  filmsWithMax.each do |movie|
    new_h = Hash.new
    new_h[movie.values_at('name')] = movie.values_at('rating')
    films << new_h
  end

  def numManipulater(floatRating, roundRating)
    string = ''
    if roundRating == 8
      string = floatRating * 10 - roundRating * 10
    elsif roundRating > 8
      string = 10 + (floatRating * 10 - roundRating * 10)
    else 
      puts 'error'
    end 
    string
  end
  final = []
    string = '*'
    fromHashToString.each do |film|
      final << film.transform_values do |rating|
        string *= numManipulater(rating, rating.round)
    end
  end
  puts final.to_s.delete('{}[]""').split(',')
end

films = fileOpen(ARGV.first)
hashFilms = findStrings(films)
filmsWithMax = somefunc(hashFilms)
ratingFunc(filmsWithMax)
