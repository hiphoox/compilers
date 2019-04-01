import os
import sys

def read_file(direc):
	with open(direc, 'r') as source: #get from the argument list the name of the file to be compiled
		if (os.stat(direc).st_size == 0):
			raise SystemExit("The file is empty.") #in case the file is empty this raises and exception and exit.
		plain_text = source.read() #to extract the plain text from the file
		print (plain_text)  
	source.close() #se cierra el archivo
	return (plain_text)