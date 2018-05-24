class ClassicMovie < Movie
  COST = 1.5
  def to_s
    "#{@name} - classic film, #{@producer}, genre: #{@genre.join(", ")}."
  end
end