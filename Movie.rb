class Movie
  attr_accessor :url, :name, :year, :country, :createdDate, :genre, :timing, :rating, :producer, :actors
  def initialize(row)
    @url = row[0]
    @name = row[1]
    @year = row[2].to_i
    @country = row[3]
    @createdDate = anyStringToDate(row[4])
    @genre = row[5]
    @timing = row[6].to_i
    @rating = ratingInStars(row[7].to_f)
    @producer = row[8]
    @actors = row[9]
  end
  def has_genre?(genre) 
    if @genre.include?(genre)
      true
    elsif genre == 'Tragedy'
      raise "No such genre!"
    else
      false
    end
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