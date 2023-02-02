require_relative '../app'

RSpec.describe Application do

  before(:each) do

    @io = double :io
    albumRepository = double :albumRepository
    artistRepository = double :artistRepository
    @app = Application.new('music_library_test',@io,albumRepository,artistRepository)

    album1 = double(:album, :title => 'Doolittle', :id =>'1')
    album2 = double(:album, :title => 'Waterloo', :id =>'2')
    
    allow(albumRepository).to receive(:all).and_return([album1,album2])

    artist1 = double(:album, :name => 'Pixies', :id =>'1')
    artist2 = double(:album, :name => 'ABBA', :id =>'2')
    
    allow(artistRepository).to receive(:all).and_return([artist1,artist2])
    
    expect(@io).to receive(:puts).with("Welcome to the music library manager!").ordered
    expect(@io).to receive(:puts).with("").ordered
    expect(@io).to receive(:puts).with("1 - List all albums").ordered
    expect(@io).to receive(:puts).with("2 - List all artists").ordered
    expect(@io).to receive(:puts).with("").ordered
    expect(@io).to receive(:puts).with("Enter your choice: ").ordered

  end

  after(:each) do
    @app.run
  end

  it 'displays a list of all albums for option 1' do

    expect(@io).to receive(:gets).and_return("1").ordered
    expect(@io).to receive(:puts).with("Here is the list of albums:").ordered
    expect(@io).to receive(:puts).with("1 - Doolittle").ordered
    expect(@io).to receive(:puts).with("2 - Waterloo").ordered
    
    
  end

  it 'displays a list of all artists for option 2' do

    expect(@io).to receive(:gets).and_return("2").ordered
    expect(@io).to receive(:puts).with("Here is the list of artists:").ordered
    expect(@io).to receive(:puts).with("1 - Pixies").ordered
    expect(@io).to receive(:puts).with("2 - ABBA").ordered
    
  end


end
