require 'date'
class NewMovie < Movie
  COST = 5
  TODAY = Date.today
  def to_s
    "#{@name} - new film,created #{ TODAY.year - @createdDate.year } years ago"
  end
end 