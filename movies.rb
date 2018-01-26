def movies(filmName)
    filmName = ARGV[0]
    case filmName
when 'Titanic'
    puts 'Titanic is a good film'
when 'Elky'
    puts 'Elky is a bad film'
else
    puts "Didn't seen " + filmName
end
end
movies(ARGV)