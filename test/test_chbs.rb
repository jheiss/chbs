#
# Test Chbs
#

require 'test/unit'
require 'chbs'
require 'json'

class ChbsTests < Test::Unit::TestCase
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
    assert_kind_of String, Chbs::CORPORA_DIRECTORY
    assert_kind_of String, Chbs::DEFAULT_CORPUS
  end
  
  def test_included_corpora
    assert_equal ['babynames', 'coca', 'gutenberg', 'tv-and-movies'], Chbs.included_corpora
  end
  
  def test_load_corpus_default
    corpus = Chbs.load_corpus
    assert_kind_of Hash, corpus
    assert corpus.length > 1000
    assert corpus['the']
    assert_kind_of Hash, corpus['the']
    assert corpus['the']['rank']
  end
  
  def test_load_corpus_custom
    Tempfile.open('chbs') do |file|
      file.write @corpus.to_json
      file.close
      
      corpus = Chbs.load_corpus(file.path)
      assert_kind_of Hash, corpus
      assert_equal 12, corpus.length
      1.upto(12) do |i|
        word = (1..i).inject('') {|word| word << 'a'}
        assert corpus[word]
        assert_kind_of Hash, corpus[word]
        assert_equal i, corpus[word]['length']
        assert_equal i, corpus[word]['rank']
      end
    end
  end
end

