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
    h = Hash.new
    h["url"] = splitLine[0]
    h['name'] = splitLine[1]
    h['year'] = splitLine[2]
    h['country'] = splitLine[3]
    h['crearedAdd'] = splitLine[4]
    h['genre'] = splitLine[5]
    h['timing'] = splitLine[6]
    h['rating'] = splitLine[7]
    h['producer'] = splitLine[8]
    h['actors'] = splitLine[9]
    film << h
  end
  film
end

def filmTiming(film)
  topLongFilm = []
  a = []
  film.each do |h|
    topLongFilm << h.values_at('timing').to_s.delete('[]""min').to_i
  end
  b = []
  d = 0
  b = topLongFilm.max_by(5) {|v| v}
  5.times do
    a << film.select do |h|
      h.value?("#{b[d]} min")
    end
    d += 1
  end
  a
end

def filmDate(film)
  comedyFilms = []
  comedyFilms << film.select do |h|
    h.values_at('genre').any? {|word| word.include? 'Comedy'}
  end
  firstComedy = []
  comedyFilms.each do |h|
    h.each do |v| 
      firstComedy << v.values_at('crearedAdd')
    end
  end
  dateArray = []
  dateArray = firstComedy.min_by(10) {|v| v}
  i = 0
  emptyArray = []
  10.times do
    emptyArray << film.select do |h|
      h.value?("#{dateArray[i]}".delete('[]""'))
    end
    i += 1
  end
  emptyArray
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
  result << "Film didn't creat in USA."
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
  topFiveTiming = []
  topFiveTiming << 'Top 5 longest film!'
  firstTenComedy = []
  firstTenComedy << 'First 10 comedy'
  fTime.each do |h|
    h.each do |v|
      topFiveTiming << "#{v.values_at('name')} (#{v.values_at('crearedAdd')}; #{v.values_at('genre')}) - #{v.values_at('timing')}".delete('""[]')
    end
  end
  fDate.each do |h|
    h.each do |v|
      firstTenComedy << "#{v.values_at('name')} (#{v.values_at('crearedAdd')}; #{v.values_at('genre')}) - #{v.values_at('timing')}".delete('""[]')
    end
  end
  puts topFiveTiming
  puts firstTenComedy
end

films = fileOpen(ARGV.first)
film = lineToHash(films)
filmTiming(film)
filmDate(film)
filmCountry(film)
producersFunc(film)
printFunc(filmTiming(film), filmDate(film))