class ModernMovie < Movie
  COST = 3
  def to_s
    "#{@name} - modern film: #{@actors} #{@rating}"
  end
end