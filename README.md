# chbs

An implementation of http://xkcd.com/936/

I.e. pick four random, common words and string them together to make a very
strong but easy to remember password.

The default corpus (word list) contains the most common words in TV and movie
scripts. A corpus of the most common words from Project Gutenberg is also
included, if you want your passwords to have a bit more of an old-timey feel.

## Installation

Add this line to your application's Gemfile:

    gem 'chbs'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chbs

## Usage

Just running chbs with no options will be sufficient in most cases.

    Usage: chbs [options]
      -c, --corpus=CORPUS      Corpus of words
      -l, --list-corpora       List included corpora
      -m, --min-length=MIN     Minimum word length
      -M, --max-length=MAX     Maximum word length
      -n, --num-words=NUM      Number of words
      -s, --separator=STRING   Word separator

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
