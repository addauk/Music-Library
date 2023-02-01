require_relative './artist'

class ArtistRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, name, genre FROM artists;'
    result_set = DatabaseConnection.exec_params(sql,[])
    artists = []
    result_set.each do |record|
      artist = Artist.new
      artist.id = record['id']
      artist.name = record['name']
      artist.genre = record['genre']
      artists << artist
    end
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists;

    # Returns an array of Artist objects.
    return artists
  end

  def find(id)
    sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql,params)
    fail "artist doesn't exist" unless  record = result_set[0]
    artist = Artist.new
    artist.id = record['id']
    artist.name = record['name']
    artist.genre = record['genre']
    return artist
  end


  def create(artist)

    sql = 'INSERT INTO artists (name,genre) VALUES($1,$2);'
    params = [artist.name,artist.genre]
    DatabaseConnection.exec_params(sql,params)

    return nil
  end

  def delete(id)
    fail "artist doesn't exist" unless artist = find(id)
    sql = 'DELETE FROM artists WHERE id = $1;'
    params = [artist.id]
    DatabaseConnection.exec_params(sql,params)
    #Doesn't need to return as only deletes
  end


  def update(artist)
    sql = "UPDATE artists SET name = $1, genre = $2 WHERE id = $3;"
    params = [artist.name,artist.genre,artist.id]
    DatabaseConnection.exec_params(sql,params)
    #Doesn't need to return as only updates
    return nil
  end

end