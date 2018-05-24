RSpec.describe Movie do
  let(:movie_collection) { MovieCollection.new('./spec/spec_movie_list.txt') }

  subject { Movie.create(movie, movie_collection) }

  context 'when ancient' do 
    let(:year) { 1940 }
    it { is_expected. to have_attributes(period: 'AncientMovie') }
  end
  
  context 'when classic' do
    let(:year) { 1958 }
    it { is_expected. to have_attributes(period: 'ClassicMovie') }
  end
  
  context 'when modern' do
    let(:year) { 1970 }
    it { is_expected. to have_attributes(period: 'ModernMovie') }
  end
  
  context 'when new' do
    let(:year) { 2100 }
    it { is_expected. to have_attributes(period: 'NewMovie') }
  end

  context 'when raise error' do 
    let(:year) {32131}
    it 'raise error' do
      expect { subject }.to raise_error(ArgumentError)
    end
  end
  
  let(:movie) {
    ["http://imdb.com/title/tt0068646/?ref_=chttp_tt_2",
    "The Godfather",
    year,
    "USA",
    "1972-03-24",
    "Drama",
    "175 min",
    "9.2",
    "Francis Ford Coppola",
    "Marlon Brando",
    "Al Pacino",
    "James Caan"]
  }

  subject(:film) { Movie.create(movie, movie_collection) }
  
  context 'has_genre?' do 
    let(:year) {2010}
    it 'check exist genre or not' do
      expect { film.has_genre?('SomeOne')}.to raise_error(ArgumentError)
      expect(film.has_genre?('Drama')).to eq(true)
    end
  end

end