## Overview

This directory contains the raw corpora data and the corpuscle script which processes the raw data into JSON corpora for chbs.

Be sure to run corpuscle under 'bundle exec', otherwise it may attempt to
update the corpus in your installed copy of the chbs gem.

## Offensive Word Filter

The offensive word filter is here to attempt to make the passphrases that chbs
generates acceptable in a modern American work environment. Thus some of the
words in the "offensive" list are not truly offensive, but references to
sexual organs and the like are usually not desirable at work.

If I've missed something (or if you think I've gone too far) let me know.
