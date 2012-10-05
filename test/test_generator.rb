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
    assert_kind_of Hash, chbs.corpus
    assert chbs.corpus.length > 1000
    assert chbs.corpus['the']
    assert_kind_of Hash, chbs.corpus['the']
    assert chbs.corpus['the']['rank']
  end
  def test_initialize_corpus
    Tempfile.open('chbs') do |file|
      file.write @corpus.to_json
      file.close
      
      chbs = Chbs::Generator.new(corpus: file.path)
      assert_kind_of Hash, chbs.corpus
      assert_equal 12, chbs.corpus.length
      1.upto(12) do |i|
        word = (1..i).inject('') {|word| word << 'a'}
        assert chbs.corpus[word]
        assert_kind_of Hash, chbs.corpus[word]
        assert_equal i, chbs.corpus[word]['length']
        assert_equal i, chbs.corpus[word]['rank']
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
      assert_match /^[a-z]{3,10}$/, word
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
      assert_match /^[a-z]{3,5}$/, word
    end
  end
  def test_generate_min_rank
    chbs = Chbs::Generator.new(min_rank: 10000)
    password = chbs.generate
    words = password.split('-')
    assert_equal 4, words.length
    words.each do |word|
      assert_match /^[a-z]{3,10}$/, word
      # FIXME: check rank
    end
  end
  def test_generate_max_rank
    chbs = Chbs::Generator.new(max_rank: 500)
    password = chbs.generate
    words = password.split('-')
    assert_equal 4, words.length
    words.each do |word|
      assert_match /^[a-z]{3,10}$/, word
      # FIXME: check rank
    end
  end
  def test_generate_num_words
    chbs = Chbs::Generator.new(num_words: 6)
    password = chbs.generate
    words = password.split('-')
    assert_equal 6, words.length
    words.each do |word|
      assert_match /^[a-z]{3,10}$/, word
    end
  end
  def test_generate_separator
    chbs = Chbs::Generator.new(separator: '=')
    password = chbs.generate
    words = password.split('=')
    assert_equal 4, words.length
    words.each do |word|
      assert_match /^[a-z]{3,10}$/, word
    end
  end
end

