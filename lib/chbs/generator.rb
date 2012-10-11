class Chbs::Generator
  DEFAULT_MIN_LENGTH = 4
  DEFAULT_MAX_LENGTH = 10
  DEFAULT_MIN_RANK = 1
  DEFAULT_MAX_RANK = 10000
  DEFAULT_NUM_WORDS = 4
  DEFAULT_SEPARATOR = '-'
  
  attr_reader :words
  def initialize(options={})
    min_length = options[:min_length] || DEFAULT_MIN_LENGTH
    max_length = options[:max_length] || DEFAULT_MAX_LENGTH
    min_rank = options[:min_rank] || DEFAULT_MIN_RANK
    max_rank = options[:max_rank] || DEFAULT_MAX_RANK
    @num_words = options[:num_words] || DEFAULT_NUM_WORDS
    @separator = options[:separator] || DEFAULT_SEPARATOR
    
    # Creating a temporary array is suboptimal, but it seems fast enough
    @words = []
    corpus = Chbs::load_corpus(options[:corpus])
    corpus.each do |word, wordstats|
      if (min_length..max_length).include?(wordstats['length']) &&
         (min_rank..max_rank).include?(wordstats['rank'])
        @words << word
      end
    end
  end
  
  def generate
    passwords = []
    @num_words.times do
      passwords << @words[rand(@words.length-1)]
    end
    passwords.join(@separator)
  end
end
