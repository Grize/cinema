def fileOpen(fileName)
  films = []
  File.open(fileName){|file| file.each do |line|
    films << line
  end}
  films
end

def findStrings(films)
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
    h['produser'] = splitLine[8]
    h['actors'] = splitLine[9]
    film << h
  end
  film
end

def somefunc(film)
  someTresh = []
  needFilms = []
  needFilms << film.select do |h| 
    h.values_at('name').any?{|word| word.include? 'Max'}
  end
  puts needFilms
end

films = fileOpen(ARGV.first)
film = findStrings(films)
somefunc(film)