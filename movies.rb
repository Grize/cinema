def movies(filmName)
    filmName = ARGV[0]
    if filmName == 'Titanick'
        puts 'Titanick is a good film'
    elsif filmName == 'Elky'
        puts 'Elky is a bad film'
    else 
        puts "Didn't see " + filmName
    end
end
movies(ARGV)