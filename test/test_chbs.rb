#
# Test Chbs
#

require 'test/unit'
require 'chbs'
require 'json'

class ChbsTests < Test::Unit::TestCase
  def test_constants
    assert_kind_of String, Chbs::CORPORA_DIRECTORY
    assert_kind_of String, Chbs::DEFAULT_CORPUS
  end
  
  def test_included_corpora
    assert_equal ['gutenberg', 'tv-and-movies'], Chbs.included_corpora
  end
end

