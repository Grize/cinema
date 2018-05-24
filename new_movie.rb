require 'date'
class NewMovie < Movie
  COST = 5
  TODAY = Date.today
  def to_s
    "#{@name},genre: #{genre.join(', ')} - new film,created #{ TODAY.year - Time.new(@createdDate).strftime("%Y").to_i } years ago"
  end
end 