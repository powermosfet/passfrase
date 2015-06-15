import argparse, random, codecs, math

parser = argparse.ArgumentParser()
parser.add_argument("filename", help="Dictionary file. One word per line")
parser.add_argument("-w", "--words", type=int, default=4, help="Number of words in generated phrase") 
parser.add_argument("-s", "--space", action="store_true", help="add space between words") 

args = parser.parse_args()

def passfrase(filename, n_words, sep):
    words = list(codecs.open(filename, encoding='utf-8'))
    phrasewords = [ random.choice(words).strip() for x in range(n_words) ]
    passfrasestring = unicode(sep).join(phrasewords)
    print passfrasestring
    print 
    print "Entropy:"
    print "If method and dictionary is known: {} bits".format(
            int(math.log(len(words)**n_words, 2)))
    print "If method is unknown: {} bits".format(
            int(math.log(95**len(passfrasestring), 2)))

sep = " " if args.space else ""
passfrase(args.filename, args.words, sep)
