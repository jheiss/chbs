# chbs

An implementation of http://xkcd.com/936/, the "correct horse battery staple" comic.

Pick four random, common words and string them together to make a very
strong but easy to remember password.

The included corpora (word lists):

* tv-and-movies: The most common words in TV and movie scripts
* gutenberg: The most common words from Project Gutenberg, gives your
  passwords a bit more of an old-timey feel.
* babynames: The top 1000 boy and girl names from the US Social Security
  Administration.
* coca: The top 5000 words from the [Corpus of Contemporary American
  English](http://www.wordfrequency.info/)

## Installation

    $ gem install chbs

## Usage

Running chbs with no options will be sufficient in most cases.

You can try decreasing the max rank, -R 1000 for example, to get more common
words and thus more easily remembered passwords. You can also have chbs
generate a bunch of passwords, -c 20 for example, and pick one that you like.

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
