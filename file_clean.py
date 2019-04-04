import os
import sys

def read_file(direc):
	with open(direc, 'r') as source: #get from the argument list the name of the file to be compiled
		if (os.stat(direc).st_size == 0):
			raise SystemExit("The file is empty.") 
		plain_text = source.read() #to extract the plain text from the file
	source.close() 
	return (plain_text)