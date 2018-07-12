

class MusicLibraryController



  def initialize(path = "./db/mp3s")
    @music = MusicImporter.new(path).import
  end

  def call
    user_input = ''
    puts "Welcome to your music library!"
      puts "What would you like to do?"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
        user_input = gets.strip
        case user_input
        when "list songs"
          list_songs
        when  "list artists"
          list_artists
        when "list genres"
          list_genres
        when "play song"
          play_song
        when "list artist"
          list_songs_by_artist
        when "list genre"
          list_genre
        when "exit"
          return
        end
      end
  end

  def list_songs
    Song.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
      puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
    end
  end

  def artists
    Artist.all.each do |artist|
      puts artist.name
    end
  end

  def genres
    Genre.all.each do |genre|
      puts genre.name
    end
  end

  def play_song
    puts "What song number would you like to play?"
    song_num = gets.chomp
    playing_song = @sorted_songs[song_num.to_i - 1]
    puts "Playing #{playing_song}"
  end

  def list_artist
    array = @music.files.collect do |file|
      song = self.class.split_filename(file)
    end
    puts "What artist would you like to list songs for?"
    artist_input = gets.chomp
    artist = Artist.find_by_name(artist_input)
    array.each do |song|
      if song[0] == artist.name
        puts "#{song[0]} - #{song[1]} - #{song[2]}"
      end
    end
  end

  def list_genre
    array = @music.files.collect do |file|
      song = self.class.split_filename(file)
    end
    puts "What genre would you like to list songs for?"
    genre_input = gets.chomp
    genre = Genre.find_by_name(genre_input)
    array.each do |song|
      if song[2] == genre.name
        puts "#{song[0]} - #{song[1]} - #{song[2]}"
      end
    end
  end
end
