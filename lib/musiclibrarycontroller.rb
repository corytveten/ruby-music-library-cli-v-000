

class MusicLibraryController

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def sorter
    @music.files.sort
  end

  def call
    puts "Welcome to your music library!"
    input = ''
    @sorted_songs = sorter
    while input != "exit"
      puts "What would you like to do?"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
        input = gets.strip
        case input
        when "list songs"
          songs
        when  "list artists"
          artists
        when "list genres"
          genres
        when "play song"
          play_song
        when "list artist"
          list_artist
        when "list genre"
          list_genre
        end
      end
  end

  def songs
    @sorted_songs.each_with_index do|song, num|
      puts "#{num+1}. #{song}"
    end
  end

end
