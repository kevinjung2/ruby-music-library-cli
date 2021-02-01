class Genre
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
    g = Genre.new(name)
    g.save
    g
  end

  def save
    self.class.all << self
  end

  def artists
    self.songs.collect {|song| song.artist }.uniq
  end

end
