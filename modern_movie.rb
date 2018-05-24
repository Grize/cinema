class ModernMovie < Movie
  COST = 3
  def to_s
    "#{@name}, genre: #{@genre.join(', ')} - modern film: #{@actors} #{@rating}"
  end
end