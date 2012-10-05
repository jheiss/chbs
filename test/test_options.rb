#
# Test chbs command line options
#

require 'test/unit'
require 'json'
require 'open4'
require 'rbconfig'
require 'tempfile'

RUBY = File.join(*RbConfig::CONFIG.values_at("bindir", "ruby_install_name")) +
         RbConfig::CONFIG["EXEEXT"]
LIBDIR = File.join(File.dirname(File.dirname(__FILE__)), 'lib')
CHBS = File.expand_path('../bin/chbs', File.dirname(__FILE__))

class ChbsOptionTests < Test::Unit::TestCase
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
  
  def test_help
    output = nil
    IO.popen("#{RUBY} -I #{LIBDIR} #{CHBS} --help") do |pipe|
      output = pipe.readlines
    end
    # Make sure at least something resembling help output is there
    assert_match('Usage: chbs [options]', output[0])
    # Make sure it fits on the screen
    assert(output.all? {|line| line.length <= 80}, 'help output columns')
    assert(output.size <= 23, 'help output lines')
  end
  
  def ensure_arg_required(option)
    output = nil
    error = nil
    status = Open4.popen4("#{RUBY} -I #{LIBDIR} #{CHBS} #{option}") do |pid, stdin, stdout, stderr|
      stdin.close
      output = stdout.readlines
      error = stderr.readlines
    end
    assert_equal(1, status.exitstatus, "#{option} arg required exitstatus")
    # Make sure the expected lines are there
    assert(error.any? {|line| line.include?("missing argument: #{option}")})
  end
  
  def test_corpus_arg_required
    ensure_arg_required('--corpus')
  end
  def test_corpus
    Tempfile.open('chbs') do |file|
      file.write @corpus.to_json
      file.close
      
      output = nil
      IO.popen("#{RUBY} -I #{LIBDIR} #{CHBS} --corpus #{file.path}") do |pipe|
        output = pipe.readlines
      end
      assert_equal 1, output.length
      words = output[0].split('-')
      assert_equal 4, words.length
      words.each do |word|
        assert_match /^a{4,10}$/, word
      end
    end
  end
  
  def test_list_corpora
    output = nil
    IO.popen("#{RUBY} -I #{LIBDIR} #{CHBS} --list-corpora") do |pipe|
      output = pipe.readlines
    end
    assert_equal 2, output.length
    assert_equal ["gutenberg\n", "tv-and-movies (default)\n"], output
  end
  
  def test_min_length_arg_required
    ensure_arg_required('--min-length')
  end
  def test_min_length
    output = nil
    IO.popen("#{RUBY} -I #{LIBDIR} #{CHBS} --min-length 8") do |pipe|
      output = pipe.readlines
    end
    assert_equal 1, output.length
    words = output[0].split('-')
    assert_equal 4, words.length
    words.each do |word|
      assert_match /^[a-z]{8,10}$/, word
    end
  end
  def test_max_length_arg_required
    ensure_arg_required('--max-length')
  end
  def test_max_length
    output = nil
    IO.popen("#{RUBY} -I #{LIBDIR} #{CHBS} --max-length 5") do |pipe|
      output = pipe.readlines
    end
    assert_equal 1, output.length
    words = output[0].split('-')
    assert_equal 4, words.length
    words.each do |word|
      assert_match /^[a-z]{4,5}$/, word
    end
  end
  
  def test_min_rank_arg_required
    ensure_arg_required('--min-rank')
  end
  def test_min_rank
    output = nil
    IO.popen("#{RUBY} -I #{LIBDIR} #{CHBS} --min-rank 5000") do |pipe|
      output = pipe.readlines
    end
    assert_equal 1, output.length
    words = output[0].split('-')
    assert_equal 4, words.length
    words.each do |word|
      assert_match /^[a-z]{4,10}$/, word
      # FIXME: check rank
    end
  end
  def test_max_rank_arg_required
    ensure_arg_required('--max-rank')
  end
  def test_max_rank
    output = nil
    IO.popen("#{RUBY} -I #{LIBDIR} #{CHBS} --max-rank 1000") do |pipe|
      output = pipe.readlines
    end
    assert_equal 1, output.length
    words = output[0].split('-')
    assert_equal 4, words.length
    words.each do |word|
      assert_match /^[a-z]{4,10}$/, word
      # FIXME: check rank
    end
  end
  
  def test_num_words_arg_required
    ensure_arg_required('--num-words')
  end
  def test_num_words
    output = nil
    IO.popen("#{RUBY} -I #{LIBDIR} #{CHBS} --num-words 6") do |pipe|
      output = pipe.readlines
    end
    assert_equal 1, output.length
    words = output[0].split('-')
    assert_equal 6, words.length
    words.each do |word|
      assert_match /^[a-z]{4,10}$/, word
    end
  end
  
  def test_count_arg_required
    ensure_arg_required('--count')
  end
  def test_count
    output = nil
    IO.popen("#{RUBY} -I #{LIBDIR} #{CHBS} --count 5") do |pipe|
      output = pipe.readlines
    end
    assert_equal 5, output.length
    0.upto(4).each do |count|
      words = output[count].split('-')
      assert_equal 4, words.length
      words.each do |word|
        assert_match /^[a-z]{4,10}$/, word
      end
    end
  end
  
  def test_separator_arg_required
    ensure_arg_required('--separator')
  end
  def test_separator
    output = nil
    IO.popen("#{RUBY} -I #{LIBDIR} #{CHBS} --separator =") do |pipe|
      output = pipe.readlines
    end
    assert_equal 1, output.length
    words = output[0].split('=')
    assert_equal 4, words.length
    words.each do |word|
      assert_match /^[a-z]{4,10}$/, word
    end
  end
  
  def test_default_operation
    output = nil
    IO.popen("#{RUBY} -I #{LIBDIR} #{CHBS}") do |pipe|
      output = pipe.readlines
    end
    assert_equal 1, output.length
    words = output[0].split('-')
    assert_equal 4, words.length
    words.each do |word|
      assert_match /^[a-z]{4,10}$/, word
    end
  end
  
  # def test_debug
  # end
end

