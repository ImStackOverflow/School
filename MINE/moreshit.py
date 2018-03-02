import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

times = 100
length = []
lengthDiff = []
frequency = []
form = '{:^8} {:>8} {:>8}'

def generate():
	for n in range(1,times):
	   k = 4 * 3.14**2 * n**2 ##new length
	   j = 4 * 3.14**2 * (n-1)**2 #old length
	   frequency.append(n)
	   length.append(int(k))
	   lengthDiff.append(int(k-j))

def table(leng, lengdiff, freq):
	print(form.format("frequency", "length", "lengthDiff")) #table header
	for f,l,ld in zip(freq, leng, lengdiff):
   		print(form.format(f, l, ld)) #print table


def graph(leng, lengdiff, freq):
	lenLeg = mpatches.Patch(color='red', label = 'length') #plot legend shit
	lenDiffLeg = mpatches.Patch(color = 'green', label = 'length diff')

	#fill table and plot
	fig, lengGraph = plt.subplots()
	lendiffGraph = lengGraph.twinx()
	for f,l,ld in zip(freq, leng, lengdiff):
	   print(form.format(f, l, ld)) #print table
	   lengGraph.plot(f,l, 'ro') #plot length
	   lendiffGraph.plot(f,ld, 'go') #plot lengthDiff
	
	lengGraph.axis([0,max(freq),0,max(leng)])
	lendiffGraph.axis([0,max(freq),0,max(leng)/2])
	lengGraph.set_ylabel('length motherFucker')
	lendiffGraph.set_ylabel('length difference cunt')
	plt.legend(handles = [lenLeg, lenDiffLeg])
	fig.tight_layout()
	plt.show()


