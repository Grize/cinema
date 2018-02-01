def movies(filmList)
    filmList.each do |filmName|
    case filmName
when 'Titanic'
    puts 'Titanic is a good film'
when 'Elky'
    puts 'Elky is a bad film'
else
    puts "Never heard about #{filmName}"
end
end
end

movies(ARGV)