def fileOpen(fileName)
  films = []
  ARGV.each do |file|
    File.open(fileName) do |file|
      file.each do |line|
        films << line 
      end
    end
  end
  films
end

def lineToHash(films)
  film = []
  films.each do |line|
    splitLine = line.split('|')
    hash = Hash.new
    hash["url"] = splitLine[0]
    hash['name'] = splitLine[1]
    hash['year'] = splitLine[2]
    hash['country'] = splitLine[3]
    hash['crearedAdd'] = splitLine[4]
    hash['genre'] = splitLine[5]
    hash['timing'] = splitLine[6]
    hash['rating'] = splitLine[7]
    hash['producer'] = splitLine[8]
    hash['actors'] = splitLine[9]
    film << hash
  end
  film
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
   arrayWithTenFirstComedy << sudenlyArray.min_by(10) do |movie|
    movie.values_at('crearedAdd').to_s.delete('[]""').to_i
   end
  end
  arrayWithTenFirstComedy
end

def filmCountry(film)
  result = []
  needFilms = []
  film.each do |h|
    if h.value?("USA") == false
      needFilms << h
    else
    end
  end
  puts result << needFilms.length
end

def producersFunc (film)
  producerList = []
  film.each do |h|
   producerList << h.values_at('producer')
  end
  puts producerList.uniq.sort_by {|s| s.to_s.delete('""[]').scan(/\w+$/)}
end

def printFunc(fTime,fDate)
  resultArrayWithFiveLongestFilm = []
  resultArrayWithComedy = []
  fTime.each do |h|
    h.each do |v|
      resultArrayWithFiveLongestFilm << "#{v.values_at('name')} (#{v.values_at('crearedAdd')}; #{v.values_at('genre')}) - #{v.values_at('timing')}".delete('""[]')
    end
  end
  fDate.each do |h|
    h.each do |v|
      resultArrayWithComedy << "#{v.values_at('name')} (#{v.values_at('crearedAdd')}; #{v.values_at('genre')}) - #{v.values_at('timing')}".delete('""[]')
    end
  end
  puts resultArrayWithFiveLongestFilm
  puts resultArrayWithComedy
end

films = fileOpen(ARGV.first)
film = lineToHash(films)
filmTiming(film)
filmDate(film)
filmCountry(film)
producersFunc(film)
printFunc(filmTiming(film), filmDate(film))