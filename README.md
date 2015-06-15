# passfrase
Generate passphrases

This is a really small python script that reads words from a text file, and picks a number of them randomly to create a passphrase. A sample file with norwegian words is included in the repository.

##Usage:
```
> python passfrase.py [-h] [-w WORDS] [-s] filename

positional arguments:
  filename              Dictionary file. One word per line

optional arguments:
  -h, --help            show this help message and exit
  -w WORDS, --words WORDS
                        Number of words in generated phrase
  -s, --space           add space between words
```

##Example:
```
> python passfrase.py -w 6 --space liste.txt
felleskommunalest antennekabler lyskopieringen glassperla glas kontraktfestes

Entropy:
If method and dictionary is known: 115 bits
If method is unknown: 505 bits
```
