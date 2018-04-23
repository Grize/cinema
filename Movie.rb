class Movie
  attr_accessor :url, :name, :year, :country, :createdDate, :genre, :timing, :rating, :producer, :actors
  def toHash
    {
    url: @url,
    name: @name,
    year: @year,
    country: @country,
    createdDate: @createdDate,
    genre: @genre,
    timing: @timing,
    rating: @rating,
    producer: @producer,
    actors: @actors
    }
  end
  
  def has_genre?(genre) 
    if @genre.include?(genre) == true
      puts true
    else
      puts "We don't have #{genre} film."
    end
  end
  def to_s
    "#{@name} - #{@year}, #{@country}, #{@createdDate} - #{@genre}, #{@timing}, #{@rating}, #{@producer}, #{@actors}"
  end
end
def anyStringToDate(row)
      if row.length == 10
      Date.parse(row)
    elsif row.length == 7
    row += '-01'
    Date.parse(row)
    else
      row += '-01-01'  #change in next time
      Date.parse(row)
    end
  end
def ratingInStars(floatRating)
  string = '*'
  string *= (floatRating - 8) * 10
end