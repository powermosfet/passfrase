# Passfrase
Generate passphrases

This is a small python script that reads words from a text file, and picks a number of them randomly to create a passphrase. A sample file with norwegian words is included in the repository.

The script is inspired by https://xkcd.com/936/

##Usage:
```
> python passfrase.py [-h] [-w WORDS] [-s] [-a ALPHABET] [--min MIN] [--max MAX]
                    filename

positional arguments:
  filename              Dictionary file. One word per line

optional arguments:
  -h, --help            show this help message and exit
  -w WORDS, --words WORDS
                        Number of words in generated phrase
  -s, --space           Add space between words
  -a ALPHABET, --alphabet ALPHABET
                        Alphabet size
  --min MIN             Minimum word length
  --max MAX             Maximum word length
```

##Example:
```
> python passfrase.py -w 6 --space --max 7 liste.txt
uskadd skruver arret joikes klappa blyregn

Entropy:
If method and dictionary is known: 96 bits
Unknown method, alphabet size 95: 295 bits
```
