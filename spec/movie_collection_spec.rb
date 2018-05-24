RSpec.describe MovieCollection do 
  let(:movie_collection) { MovieCollection.new('./spec/spec_movie_list.txt') }

  describe '#all' do
    
    it 'return all movies' do 
      expect(movie_collection.all).to be_an(Array)
      expect(movie_collection.all).not_to be_empty
    end
  
  end

  describe '#sort_by' do 

    it 'sort by year' do 
      expect(movie_collection.sort_by(:year).first.year).to eq("1942")
    end

    it 'sort by timing' do 
      expect(movie_collection.sort_by(:timing).map { |m| m.timing}).to eq([88, 148, 175, 201, 207])
    end

    it 'raise error with wrong argument' do 
      expect { movie_collection.sort_by(:wrong) }.to raise_error(ArgumentError)
    end
  end

  describe '#stats' do 

    it 'movie collection' do 
      expect(movie_collection.stats(:actors)).to eq(
        {"Marlon Brando"=>1,
          "Al Pacino"=>1,
          "Elijah Wood" => 1,
          "James Caan"=>1,
          "Leonardo DiCaprio"=>1,
          "Joseph Gordon-Levitt"=>1,
          "Ellen Page"=>1,
          "Toshirô Mifune"=>1,
          "Viggo Mortensen" => 1,
          "Takashi Shimura"=>1,
          "Keiko Tsushima"=>1,
          "Humphrey Bogart"=>1,
          "Ian McKellen" => 1,
          "Ingrid Bergman"=>1,
          "Paul Henreid"=>1})
        end
      
      end
end