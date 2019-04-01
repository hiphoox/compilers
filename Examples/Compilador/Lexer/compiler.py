import  sys
from file_clean import *
from lexer_module import *

try:
	raw_text = read_file(sys.argv[1])
except IOError as e: #excepción en caso de que el archivo no exista 
	print(e)
	print("Unable to read the file ", sys.argv[1])
except IndexError as e: #excepción en caso de que 
	print(e)
	print("No arguments were provided")

token_list = lexer(raw_text)
print(token_list)