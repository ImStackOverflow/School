
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

times = 6
length = []
lengthDiff = []
frequency = []
ImAFreq = 0 #initial frequency specified, otherwise length specified
initalFreq = 1
dickLength = 25 #string lenght in cm

#calculates a frequency given length
#length is given in cm bitch
def findFrequency(initialLengthBitch):
	t = float(initialLengthBitch)/980
	t = t**(0.5)
	t *= 2*3.14159
	return 1/t

#does formula to show length
#i.e. f(frequency) = length
def generate():
	#either use inital frequency or length BITCH
	if not ImAFreq:
		f1 = findFrequency(dickLength)
	else:
		f1 = int(initalFreq) 
	#print("inital freq is: "+ str(f1))
	for n in range(1,times):
	   freq = n*f1
	   k = 4 * 3.14**2 * freq**2 #length from frequency
	   k = 980/k
	   #j = 4 * 3.14**2 * (freq-1)**2 #old length
	   frequency.append(freq)
	   length.append(k)
	   x = (0 if n-1 < 0 else n-2)
	   lengthDiff.append(abs(k-length[x]))
	   #print("frequency is: "+str(freq))

def table():
	print('{:^8} {:>8} {:>8}'.format("frequency(Hz)	", "length(cm)", "lengthDiff(cm)")) #table header
	for f,l,ld in zip(frequency, length, lengthDiff):
   		print('{:^12.2f} {:>12.2f} {:>12.2f}'.format(f, l, ld)) #print table

def graph():
	lenLeg = mpatches.Patch(color='red', label = 'length') #plot legend shit
	lenDiffLeg = mpatches.Patch(color = 'green', label = 'length diff')

	#fill table and plot
	fig, lengGraph = plt.subplots()
	lendiffGraph = lengGraph.twinx()
	lengGraph.plot(frequency, length, 'b--')
	lendiffGraph.plot(frequency, lengthDiff, 'r--')

	#show shit
	lengGraph.axis([0,max(frequency),0,max(length)])
	lendiffGraph.axis([0,max(frequency),0,max(length)/2])
	lengGraph.set_ylabel('length motherFucker')
	lendiffGraph.set_ylabel('length difference cunt')
	plt.legend(handles = [lenLeg, lenDiffLeg])
	fig.tight_layout()
	plt.show()

if __name__ == '__main__':
	generate()
	table()
	graph()



