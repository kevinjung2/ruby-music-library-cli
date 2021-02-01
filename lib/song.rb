require "pry"
class Song
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    self.name = name
    self.artist = artist
    self.genre = genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def self.create(name)
    s = Song.new(name)
    s.save
    s
  end

  def save
    self.class.all << self
  end

  def artist=(artist)
    if artist != nil
      @artist = artist
      artist.add_song(self)
    end
  end

  def genre=(genre)
    if genre != nil
      @genre = genre
      genre.songs << self unless genre.songs.include?(self)
    end
  end

  def self.find_by_name(name)
    self.all.find {|song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) ? self.find_by_name(name) : Song.create(name)
  end

  def self.new_from_filename(file)
    split = file.split(/ - |.mp3/)
    artist = Artist.find_or_create_by_name(split[0])
    genre = Genre.find_or_create_by_name(split[2])
    Song.new(split[1], artist, genre)
  end

  def self.create_from_filename(file)
    new = self.new_from_filename(file)
    self.all << new
    new
  end
end
