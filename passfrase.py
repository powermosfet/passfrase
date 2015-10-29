import argparse, random, codecs, math

def passfrase(filename, n_words, sep, alphabet, min, max):
    words = list(codecs.open(filename, encoding='utf-8'))
    words = [ w.strip() for w in words ]
    words = [ w for w in words if len(w) >= min and len(w) <= max ]
    if not words:
        print("ERROR: No words left")
        return
    phrasewords = [ random.choice(words) for x in range(n_words) ]
    passfrasestring = sep.join(phrasewords)
    print(passfrasestring)
    print()
    print("Entropy:")
    print("If method and dictionary is known: {} bits".format(
            int(math.log(len(words)**n_words, 2))))
    print("Unknown method, alphabet size {}: {} bits".format(
            alphabet, 
            int(math.log(alphabet**len(passfrasestring), 2))))

parser = argparse.ArgumentParser()
parser.add_argument("filename", help="Dictionary file. One word per line")
parser.add_argument("-w", "--words", type=int, default=4, help="Number of words in generated phrase") 
parser.add_argument("-s", "--space", action="store_true", help="Add space between words") 
parser.add_argument("-a", "--alphabet", type=int, default=95, help="Alphabet size") 
parser.add_argument("--min", type=int, default=3, help="Minimum word length") 
parser.add_argument("--max", type=int, default=100, help="Maximum word length") 

args = parser.parse_args()

sep = " " if args.space else ""
passfrase(args.filename,
          args.words,
          sep,
          args.alphabet,
          args.min,
          args.max
         )
