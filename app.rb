# file: app.rb

require_relative './lib/album_repository'
require_relative './lib/artist_repository'
require_relative './lib/database_connection.rb'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.
    welcome_message
    present_menu
    handle_choice
    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
  end

  private

  def welcome_message
    @io.puts("Welcome to the music library manager!")
    @io.puts("")
  end

  def present_menu
    @io.puts("1 - List all albums")
    @io.puts("2 - List all artists")
    @io.puts("")
    @io.puts("Enter your choice: ")
  end

  def handle_choice
    choice = @io.gets.chomp
    if choice == "1"
      display_albums
    elsif choice == "2"
      display_artists
    end
  end

  def display_albums
    @io.puts("Here is the list of albums:")

    @album_repository.all.each do |album|
      @io.puts("#{album.id} - #{album.title}")
    end

  end

  def display_artists

    @io.puts("Here is the list of artists:")

    @artist_repository.all.each do |artist|
      @io.puts("#{artist.id} - #{artist.name}")
    end

  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end