require 'json'
require 'nokogiri'

class Chbs::Generator
  attr_reader :corpus
  def initialize(options={})
    corpusname = options[:corpus] || Chbs::DEFAULT_CORPUS
    
    corpusfile = nil
    if corpusname.include?('/')
      corpusfile = corpusname
    else
      corpusfile = File.join(Chbs::CORPORA_DIRECTORY, "#{corpusname}.json")
    end
    @corpus = JSON.parse(File.read(corpusfile))
  end
  
  def generate(options={})
    min_length = options[:min_length] || 3
    max_length = options[:max_length] || 10
    num_words = options[:num_words] || 4
    separator = options[:separator] || '-'
    
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
    passwords.join(separator)
  end
end
