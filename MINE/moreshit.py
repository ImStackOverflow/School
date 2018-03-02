import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

times = 4
length = []
lengthDiff = []
frequency = []
form = '{:^8} {:>8} {:>8}'
ImAFreq = False #initial frequency specified
initalFreq = 1
dickLength = 4 #string lenght in cm

#calculates a frequency given length
#length is given in cm bitch
def findFrequency(initialLengthBitch):
	t = 2*3.14159*((initialLengthBitch/980)**(1/2))
	print('init time: '+str(t))
	return 1/t

#does formula to show length
#i.e. f(frequency) = length
def generate():
	#either use inital frequency or length BITCH
	'''if ImAFreq:
		global initalFreq 
		initalFreq = findFrequency(dickLength)
	print("inital freq is: "+ str(initalFreq))
	'''
	for n in range(1,times):
	   freq = n*initalFreq
	   k = 4 * 3.14**2 * freq**2 #new length
	   j = 4 * 3.14**2 * (freq-1)**2 #old length
	   frequency.append(freq)
	   length.append(int(k))
	   lengthDiff.append(int(k-j))
	   print("frequency is: "+str(freq))

def table():
	print(form.format("frequency", "length(cm)", "lengthDiff(cm)")) #table header
	for f,l,ld in zip(frequency, length, lengthDiff):
   		print(form.format(f, l, ld)) #print table

def graph():
	lenLeg = mpatches.Patch(color='red', label = 'length') #plot legend shit
	lenDiffLeg = mpatches.Patch(color = 'green', label = 'length diff')

	#fill table and plot
	fig, lengGraph = plt.subplots()
	lendiffGraph = lengGraph.twinx()
	for f,l,ld in zip(frequency, length, lengthDiff):
	   lengGraph.plot(f,l, 'ro') #plot length
	   lendiffGraph.plot(f,ld, 'go') #plot lengthDiff
	
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



