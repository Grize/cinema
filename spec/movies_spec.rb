

RSpec.describe 'Movies' do 
  let!(:films) {checkForFile}
  let!(:film) {checkForFile.first}
  context 'checkForFile' do 
    it 'should return array' do
      expect(films.is_a?(Array)).to eq(true)
    end
    it 'should return hash' do 
      expect(film.is_a?(Hash)).to eq(true)
    end
    it 'should return 250 hash in array' do 
      expect(films.length).to eq(250)
    end
    #it 'should return error' do 
     # expect {ARGV.first == 'movis.txt'}.to eq(IOError)
    #end
  end
  context 'doArrayWithHash' do 
    it 'should return integer in year' do
      expect(film.values_at(:year).first.is_a?(Integer)).to eq(true)
    end
    it 'should return stars in rating' do 
      expect(film.values_at(:rating).first.include? "*").to eq(true)
    end
    it 'should return 10 keys' do 
      expect(film.length).to eq(10)
    end
    it 'should return integer in timing' do 
      expect(film.values_at(:timing).first.is_a?(Integer)).to eq(true)
    end
  end
  context 'anyStringToDate' do
    it 'should return date' do 
      expect(film.values_at(:createdDate).first.is_a?(Date)).to eq(true)
    end
    it 'should be full date' do 
      expect(film.values_at(:createdDate).first.to_s.length).to eq(10)
    end
  end
  context 'sortByCreatedDate' do 
    it 'should return hash' do 
      expect(sortByCreatedDate(films).is_a?(Hash)).to eq(true)
    end
    it 'should return 12 keys' do 
      expect(sortByCreatedDate(films).length).to eq(12)
    end
    it 'should be integer in value' do 
      expect(sortByCreatedDate(films).values.first.is_a?(Integer)).to eq(true)
    end
  end
  context 'findFilmsWithMax' do 
    it 'should return array' do 
      expect(findFilmsWithMax(films).is_a?(Array)).to eq(true)
    end
    it 'should return hash' do
      expect(findFilmsWithMax(films).first.is_a?(Hash)).to eq(true)
    end
    it 'should be Max in name' do
      expect(findFilmsWithMax(films).first.values_at(:name).first.include? 'Max').to eq(true)
    end
  end
  #context 'printNameAndRating' do
   # it 'should return string' do
   # end
  #end
  context 'filmTiming' do 
    it 'should return array with 5 films' do 
      expect(filmTiming(films).first.length).to eq(5)
    end
  end
  context 'filmDate' do 
    it 'should return array with comedy films' do
      expect(filmDate(films).first.first.values_at(:genre).first.include? 'Comedy').to eq(true)
    end
    it 'should return array with 10 films' do 
      expect(filmDate(films).first.length).to eq(10)
    end
  end
  context 'filmCountry' do 
    it 'should return integer' do 
      expect(filmCountry(films).class).to eq(Integer)
    end
    # ask how check country
  end
  context 'producersList' do 
    it 'should return array' do 
      expect(producersList(films).class).to eq(Array)
    end
  end
end 