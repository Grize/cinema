class AncientMovie < Movie
  COST = 1
  def to_s
    "#{@name}, genre: #{@genre.join(', ')} - ancient film (#{@year})"
  end
end