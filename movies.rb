<<<<<<< HEAD
def movies(filmList)
    filmList.each do |filmName|
    case filmName
=======
def movies(filmName)
  ARGV.each do |filmName|
  case filmName
>>>>>>> afb87bdb6dfedc1ade1fab26b1d0e06bbd111bce
when 'Titanic'
  puts 'Titanic is a good film'
when 'Elky'
  puts 'Elky is a bad film'
else
<<<<<<< HEAD
    puts "Never heard about #{filmName}"
end
end
end

movies(ARGV)
=======
  puts 'Never heard about ' + filmName
  end
  end
end
>>>>>>> afb87bdb6dfedc1ade1fab26b1d0e06bbd111bce
