require 'json'
require 'nokogiri'

class Chbs::Generator
  def initialize(options={})
    corpusname = options[:corpus] || 'tv-and-movies'
    
    corpusdir = File.expand_path('../../../corpus/', __FILE__)
    corpusfile = File.join(corpusdir, "#{corpusname}.json")
    @corpus = JSON.parse(File.read(corpusfile))
  end
  
  def generate(options={})
    min_length = options[:min_length] || 3
    max_length = options[:max_length] || 10
    num_words = options[:num_words] || 4
    
    # Creating a temporary array is suboptimal, but it seems fast enough
    words = []
    min_length.upto(max_length) do |i|
      if @corpus[i.to_s]
        words.concat(@corpus[i.to_s])
      end
    end
    
    passwords = []
    num_words.times do
      passwords << words[rand(words.length-1)]
    end
    passwords.join('-')
  end
end
