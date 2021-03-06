#
# Test Chbs::Generator
#

require 'test/unit'
require 'chbs'
require 'json'

class ChbsGeneratorTests < Test::Unit::TestCase
  def setup
    @corpus = {
      'a' => {rank: 1,  length: 1},
      'aa' => {rank: 2,  length: 2},
      'aaa' => {rank: 3,  length: 3},
      'aaaa' => {rank: 4,  length: 4},
      'aaaaa' => {rank: 5,  length: 5},
      'aaaaaa' => {rank: 6,  length: 6},
      'aaaaaaa' => {rank: 7,  length: 7},
      'aaaaaaaa' => {rank: 8,  length: 8},
      'aaaaaaaaa' => {rank: 9,  length: 9},
      'aaaaaaaaaa' => {rank: 10, length: 10},
      'aaaaaaaaaaa' => {rank: 11, length: 11},
      'aaaaaaaaaaaa' => {rank: 12, length: 12},
    }
  end
  
  def test_constants
    assert_kind_of Integer, Chbs::Generator::DEFAULT_MIN_LENGTH
    assert_kind_of Integer, Chbs::Generator::DEFAULT_MAX_LENGTH
    assert_kind_of Integer, Chbs::Generator::DEFAULT_MIN_RANK
    assert_kind_of Integer, Chbs::Generator::DEFAULT_MAX_RANK
    assert_kind_of Integer, Chbs::Generator::DEFAULT_NUM_WORDS
    assert_kind_of String, Chbs::Generator::DEFAULT_SEPARATOR
  end
  
  def test_initialize_default_operation
    chbs = Chbs::Generator.new
    assert_kind_of Array, chbs.words
    assert_includes 7250..10000, chbs.words.length
    assert_include chbs.words, 'about'
  end
  def test_initialize_corpus
    Tempfile.open('chbs') do |file|
      file.write @corpus.to_json
      file.close
      
      chbs = Chbs::Generator.new(corpus: file.path)
      assert_kind_of Array, chbs.words
      assert_equal 7, chbs.words.length
      4.upto(10) do |i|
        word = (1..i).inject('') {|word| word << 'a'}
        assert_includes chbs.words, word
      end
    end
  end
  
  def test_generate_default_operation
    chbs = Chbs::Generator.new
    password = chbs.generate
    assert_kind_of String, password
    words = password.split('-')
    assert_equal 4, words.length
    words.each do |word|
      assert_match /^[a-z]{4,10}$/, word
    end
  end
  def test_generate_min_length
    chbs = Chbs::Generator.new(min_length: 8)
    password = chbs.generate
    words = password.split('-')
    assert_equal 4, words.length
    words.each do |word|
      assert_match /^[a-z]{8,10}$/, word
    end
  end
  def test_generate_max_length
    chbs = Chbs::Generator.new(max_length: 5)
    password = chbs.generate
    words = password.split('-')
    assert_equal 4, words.length
    words.each do |word|
      assert_match /^[a-z]{4,5}$/, word
    end
  end
  def test_generate_min_rank
    chbs = Chbs::Generator.new(min_rank: 5000)
    password = chbs.generate
    words = password.split('-')
    assert_equal 4, words.length
    corpus = Chbs.load_corpus
    words.each do |word|
      assert_match /^[a-z]{4,10}$/, word
      assert_includes 5000..10000, corpus[word]['rank']
    end
  end
  def test_generate_max_rank
    chbs = Chbs::Generator.new(max_rank: 1000)
    password = chbs.generate
    words = password.split('-')
    assert_equal 4, words.length
    corpus = Chbs.load_corpus
    words.each do |word|
      assert_match /^[a-z]{4,10}$/, word
      assert_includes 1..1000, corpus[word]['rank']
    end
  end
  def test_generate_num_words
    chbs = Chbs::Generator.new(num_words: 6)
    password = chbs.generate
    words = password.split('-')
    assert_equal 6, words.length
    words.each do |word|
      assert_match /^[a-z]{4,10}$/, word
    end
  end
  def test_phrase_length
    chbs = Chbs::Generator.new(phrase_length: 100)
    password = chbs.generate
    # Worst case is that we generate a phrase that is 101 characters long with
    # a DEFAULT_MAX_LENGTH (10 character) word in the last place.  Once we pop
    # that off we'll lose 10 characters from the word plus a separator,
    # leaving a 90 character phrase.
    assert_includes 90..100, password.length
  end
  def test_generate_separator
    chbs = Chbs::Generator.new(separator: '=')
    password = chbs.generate
    words = password.split('=')
    assert_equal 4, words.length
    words.each do |word|
      assert_match /^[a-z]{4,10}$/, word
    end
  end
end

