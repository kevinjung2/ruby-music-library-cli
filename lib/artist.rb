class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    self.name = name
    self.songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def self.create(name)
    a = Artist.new(name)
    a.save
    a
  end

  def save
    self.class.all << self
  end

  def add_song(song)
    song.artist = self if song.artist == nil
    songs << song if songs.include?(song) == false
  end

  def genres
    self.songs.collect {|song| song.genre }.uniq
  end

end
