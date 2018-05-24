RSpec.describe Theater do 
  let(:theater) { Theater.new('./spec/spec_movie_list.txt') }

  describe '#show' do 
    it 'check rigth genre and film types show in right time' do
      expect { theater.show(8) }.to output(/ancient film/).to_stdout
      expect { theater.show(13) }.to output(/Comedy|Adventure/).to_stdout
      expect { theater.show(22) }.to output(/Horror|Drama/).to_stdout
    end
  end

  describe '#when?' do
    it 'check that movies shows in rigth time' do 
      expect { theater.when?('Casablanca') }.to output("from 7 to 12\n").to_stdout
      expect { theater.when?('Intouchables') }.to output("from 12 to 16\n").to_stdout
      expect { theater.when?('Seven Samurai') }.to output("from 16 to 23\n").to_stdout
    end
  end
  
end