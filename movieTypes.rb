class AncientMovie < Movie
  COST = 1
  def to_s
    "#{@name} - ancient film (#{@year})"
  end
end