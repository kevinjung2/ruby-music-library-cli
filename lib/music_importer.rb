class MusicImporter
  attr_accessor :path, :files

  def initialize(path)
    self.path = path
  end

  def files
    f = Dir.entries(self.path)
    self.files = f.select { |file| file.match(/.*.mp3/) }
  end

  def import
    files.select { |file| file.match(/.*.mp3/) }.collect { |file| Song.create_from_filename(file) }
  end
end
