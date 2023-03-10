require_relative '../lib/album_repository'

RSpec.describe AlbumRepository do

  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test'})
    connection.exec(seed_sql)

  end

  before(:each) do
    reset_albums_table
  end


  it 'returns the list of albums' do

    repo = AlbumRepository.new

    albums = repo.all
    expect(albums.length).to eq 2
    expect(albums.first.id).to eq '1'
    expect(albums.first.title).to eq 'Doolittle'

  end

  it 'finds an album matching the id' do

    repo = AlbumRepository.new

    album = repo.find(1)
    expect(album.title).to eq 'Doolittle'

  end

  it 'creates a new album' do
    repository = AlbumRepository.new

    album = Album.new
    album.title = 'Trompe le Monde'
    album.release_year = "1991"
    album.artist_id = "1"

    repository.create(album)

    expect(repository.all.last.title).to eq 'Trompe le Monde'
    expect(repository.all.last.release_year).to eq '1991'
    expect(repository.all.last.artist_id).to eq '1'
    
  end

end