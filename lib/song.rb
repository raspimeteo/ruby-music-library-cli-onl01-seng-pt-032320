require 'pry'
class Song

  attr_accessor :name, :artist, :genre

  extend Concerns::Findable

  @@all = []

  def initialize(name, artist = nil,genre = nil)
    @name = name
    self.artist = artist if artist != nil
    self.genre = genre if genre != nil
    save
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    self.new(name)
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.new_from_filename(filename)
    song_name = filename.split(" - ")[1]
    artist_name = ( filename.split(" - ")[0])
    genre_name = filename.split(" - ")[2].delete_suffix(".mp3")
    artist = Artist.find_or_create_by_name(artist_name)
    @artist = artist
    genre = Genre.find_or_create_by_name(genre_name)
    @genre = genre
    song = self.new(song_name, @artist, @genre)
    song.artist = artist
    song
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end

end
