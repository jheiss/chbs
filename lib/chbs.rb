require "chbs/version"
require "chbs/generator"

module Chbs
  CORPORA_DIRECTORY = File.expand_path('../../corpora/', __FILE__)
  DEFAULT_CORPUS = 'tv-and-movies'
  
  def self.included_corpora
    Dir.glob(File.join(CORPORA_DIRECTORY, '*.json')).collect{|c| File.basename(c, '.json')}.sort
  end
end
