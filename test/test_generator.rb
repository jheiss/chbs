#
# Test Chbs::Generator
#

require 'test/unit'
require 'chbs'
require 'json'

class ChbsGeneratorTests < Test::Unit::TestCase
  def setup
    @corpus = {
      '1'  => ['a'],
      '2'  => ['aa'],
      '3'  => ['aaa'],
      '4'  => ['aaaa'],
      '5'  => ['aaaaa'],
      '6'  => ['aaaaaa'],
      '7'  => ['aaaaaaa'],
      '8'  => ['aaaaaaaa'],
      '9'  => ['aaaaaaaaa'],
      '10' => ['aaaaaaaaaa'],
      '11' => ['aaaaaaaaaaa'],
      '12' => ['aaaaaaaaaaaa'],
    }
  end
  
  def test_initialize_default_operation
    chbs = Chbs::Generator.new
    assert_kind_of Hash, chbs.corpus
    assert chbs.corpus['3']
    assert chbs.corpus['3'].length > 1000
  end
  def test_initialize_corpus
    Tempfile.open('chbs') do |file|
      file.write @corpus.to_json
      file.close
      
      chbs = Chbs::Generator.new(corpus: file.path)
      assert_kind_of Hash, chbs.corpus
      assert_equal 12, chbs.corpus.length
      1.upto(12) do |i|
        assert chbs.corpus[i.to_s]
        assert_equal 1, chbs.corpus[i.to_s].length
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
    chbs = Chbs::Generator.new
    password = chbs.generate(min_length: 8)
    words = password.split('-')
    assert_equal 4, words.length
    words.each do |word|
      assert_match /^[a-z]{8,10}$/, word
    end
  end
  def test_generate_max_length
    chbs = Chbs::Generator.new
    password = chbs.generate(max_length: 5)
    words = password.split('-')
    assert_equal 4, words.length
    words.each do |word|
      assert_match /^[a-z]{3,5}$/, word
    end
  end
  def test_generate_num_words
    chbs = Chbs::Generator.new
    password = chbs.generate(num_words: 6)
    words = password.split('-')
    assert_equal 6, words.length
    words.each do |word|
      assert_match /^[a-z]{3,10}$/, word
    end
  end
end

