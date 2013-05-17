# chbs

An implementation of http://xkcd.com/936/, aka "correct horse battery staple".

I.e. pick four random, common words and string them together to make a very
strong but easy to remember password.

The default corpus (word list) contains the most common words in TV and movie
scripts.

Additional corpora are included:

* gutenberg: The most common words from Project Gutenberg, gives your
  passwords a bit more of an old-timey feel.
* coca: The top 5000 words from the [Corpus of Contemporary American
  English](http://www.wordfrequency.info/)

## Installation

Install it yourself as:

    $ gem install chbs

Or add this line to your application's Gemfile:

    gem 'chbs'

And then execute:

    $ bundle

## Usage

Just running chbs with no options will be sufficient in most cases.

Decrease max rank, -R 1000 for example, to get more common words and thus more
easily remembered passwords. You can have chbs generate a bunch of passwords,
-c 20 for example, and pick one that you like.

    Usage: chbs [options]
      -C, --corpus=CORPUS      Corpus of words
          --list-corpora       List included corpora
      -l, --min-length=MIN     Minimum word length [4]
      -L, --max-length=MAX     Maximum word length [10]
      -r, --min-rank=MIN       Minimum word rank [1]
      -R, --max-rank=MAX       Maximum word rank [10000]
      -n, --num-words=NUM      Number of words [4]
      -p, --phrase-length=LEN  Length of passphrase
      -s, --separator=STRING   Word separator [-]
      -c, --count=COUNT        Number of passwords [1]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
