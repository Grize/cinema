def fileOpen(fileName)
  films = []
  if ARGV.empty?
    File.open('movies.txt') do |film|
      film.each do |line|
        films << line
      end
    end
  else
    ARGV.each do |fileName|
      if File.exist?(fileName)
        File.open(fileName) do |file|
          file.each do |line|
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

def somefunc(film)
  film.select do |h| 
    h.values_at('name').any?{|word| word.include? 'Godfather'}
  end
end

def ratingFunc(arr)
  film = []
  arr.each do |h|
    new_h = Hash.new
    new_h[h.values_at('name')] = h.values_at('rating')
    film << new_h
  end
  
  fromHashToString =[]
   film.each do |h|
   fromHashToString << h.transform_values {|v| v.to_s.delete('{},[],""').to_f}
  end

  def numManipulater(v, roundV)
    string = ''
    if roundV == 8
      string = v * 10 - roundV * 10
    elsif roundV > 8
      string = 10 + (v * 10 - roundV * 10)
    else 
      puts 'error'
    end 
    string
  end
  final = []
    string = '*'
    fromHashToString.each do |h|
      final << h.transform_values do |v|
        string *= numManipulater(v, v.round)
    end
  end
  puts final.to_s.delete('{}[]""').split(',')
end

films = fileOpen(ARGV.first)
film = findStrings(films)
arr = somefunc(film)
ratingFunc(arr)