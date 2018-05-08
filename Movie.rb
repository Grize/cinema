class Movie
  attr_accessor :url, :name, :year, :country, :createdDate, :genre, :timing, :rating, :producer, :actors
  def has_genre?(genre) 
    if @genre.include?(genre)
      true
    elsif genre == 'Tragedy'
      raise "No such genre!"
    else
      false
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