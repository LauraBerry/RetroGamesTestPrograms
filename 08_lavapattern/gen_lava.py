#! /usr/bin/env python
# Test program for the LCG/lava generation
import sys
from subprocess import call

a = 33        # Multiplier (This multiplication can be easily done without bit shifting)
c = 1         # Constant
m = pow(2,16)   # Modulus (We're going for a 16 bit modulus. Because that's built in.)
def LCG(seed):
    return ((seed * a) + c) % m

rows = 23
cols = 22
num = int(sys.argv[1]) # The seed value for the LCG
threshold = 32000 # If we're above this value, we're lava. Else, we're ground.

# Loop through and keep printing the noise.
while True:
    call(["clear"])

    for x in range(1,rows):
        for y in range(1,cols):
            num = LCG(num)
            if num > threshold:
                print '#',
            else:
                print '.',

            # print num,'\t',format(num, '016b')
        print 
     
    call(["sleep","0.5"])
