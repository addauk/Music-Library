require_relative '../lib/artist_repository'

RSpec.describe ArtistRepository do

  def reset_artists_table
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test'})
    connection.exec(seed_sql)

  end

  before(:each) do
    reset_artists_table
  end


  it 'returns the list of artists' do

    repo = ArtistRepository.new

    artists = repo.all
    expect(artists.length).to eq 2
    expect(artists.first.id).to eq '1'
    expect(artists.first.name).to eq 'Pixies'

  end

    it 'finds an artist matching the id' do

    repo = ArtistRepository.new

    artist = repo.find(1)
    expect(artist.name).to eq 'Pixies'

  end

  it 'creates a new artist' do
    repo = ArtistRepository.new

    artist = Artist.new
    artist.name = 'Daft Punk'
    artist.genre = 'Electronic'
    repo.create(artist)

    expect(repo.all.last.name).to eq artist.name
  end

  it 'deletes an artist that matches the id' do
    repo = ArtistRepository.new
    artist = repo.find(1)
    repo.delete(artist.id)

    expect(repo.all.length).to eq 1
    expect(repo.all.first.id).to eq '2'  
  end

  it 'deletes two artists' do
    repo = ArtistRepository.new
    repo.delete(1)
    repo.delete(2)

    expect(repo.all.length).to eq 0 
  end

  it 'updates an artist' do
    
    repo = ArtistRepository.new

    artist = repo.find(1)

    artist.name = 'Bingo'
    artist.genre = 'Dubstep'

    repo.update(artist)

    updated_artist = repo.find(1)

    expect(updated_artist.name).to eq 'Bingo'
    expect(updated_artist.genre).to eq 'Dubstep'
  end

end