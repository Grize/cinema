RSpec.describe Netflix do
  let(:netflix) { Netflix.new('./spec/spec_movie_list.txt') }

  describe '#pay' do 
    it 'change money' do
      expect { netflix.pay(9) }.to change { netflix.money }.from(0).to(9)
    end
  end

  describe '#how_much?' do
    
    it 'show movie cost' do 
      expect(netflix.how_much?('The Godfather')).to eq(3)
      expect(netflix.how_much?('Inception')).to eq(5)
      expect(netflix.how_much?('Seven Samurai')).to eq(1.5)
      expect(netflix.how_much?('Casablanca')).to eq(1)
    end
  end

  describe '#show' do 
    before {netflix.pay(10)}

    it 'check genre and type of film' do 
      expect { netflix.show('Drama', :classic) }.to output("Now showing: Seven Samurai, time start: #{Time.new.strftime("%H:%M:%S")} - time end: #{(Time.new + (netflix.all[2].timing * 60)).strftime("%H:%M:%S")} \n").to_stdout
    end
  end

end