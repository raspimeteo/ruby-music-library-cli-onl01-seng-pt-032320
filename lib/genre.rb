require 'pry'
class Genre

  attr_accessor :name, :songs

  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    save
    @songs = []
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

  # #artists returns a collection of artists for all of the genre's songs (genre has many artists through songs)
  def artists
    # binding.pry
    artists = @songs.collect {|song| song.artist}
    # binding.pry
    artists.uniq
  end


end
