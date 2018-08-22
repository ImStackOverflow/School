import miller_rabin as dick
import random, struct

BITCHLENGTH = 64 #bits in each prime final key is twice the length 
COCKLENGTH = BITCHLENGTH*2 - 1 #block length message is broken up into




def generatePrime():
    ass = random.getrandbits(BITCHLENGTH) #generate random number
    ass | 1 #make it odd
    if dick.miller_rabin(ass, 1000) != True: #make sure that shit prime
	   return generatePrime()
    return ass

#function to generate e, d, and n from 2 primes p and q
#returns dict with data inside
def makeData(p, q):

    #make private key
    penis = generatePrime()
    while penis < max(p,q):
        penis = generatePrime()

    dick = {
        'privateKey' : penis,
        'publicKey' : ,
        'modulus' : p*q
     }
    return dick
    

#wrapper function
#takes in message file, key
def encrypt(message, pubic, encrypted):  
    try:
        dick = open(message, 'rb')
        return fuckmeup(dick, pubic)
    except OSError:
        print('not a real file fuker to encrypt')
    except:
        print('error in encryption fucker')



def fuckmeup(message, key):  #heavy lifting of the real shit
    while true:
        byte = message.read(COCKLENGTH)
        if !byte: #end of file, pad and continue encrypting
            byte << COCKLENGTH - sys.getsizeof(byte) 
        bits = struct.unpack('i' * COCKLENGTH, byte) #gives each message chunk as bits
        print bits

    print 'eat my penis'


        

if __name__ == '__main__':
    ass = generatePrime()
    gooch = generatePrime()
    print('gooch fuckin is: '+ str(gooch))
    print('ass fuckin is: '+str(ass))
