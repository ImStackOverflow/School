import miller_rabin as dick
import random

BITCHLENGTH = 64 #bits in each prime final key is twice the length 
COCKLENGTH = BITCHLENGTH*2 #block length message is broken up into

def generatePrime():
    ass = random.getrandbits(256) #generate random 256 bit number
    ass | 1 #make it odd
    dick.miller_rabin(ass, 1000) #make sure that shit prime
    return ass

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

if __name__ == '__main__':
    ass = generatePrime()
    gooch = generatePrime()
    print('gooch fuckin is: '+ str(gooch))
    print('ass fuckin is: '+str(ass))
