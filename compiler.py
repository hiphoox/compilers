import  sys
import argparse
from file_clean import *
from lexer_module import *
from parser_module import *

parser = argparse.ArgumentParser()
group = parser.add_mutually_exclusive_group()
parser.add_argument("file", type=str, help="name of the C file")
parser.add_argument("-o", "--output", type=str, help="Write output to <OUTPUT>")
group.add_argument("-s" , "--ensamblador", action = "store_true", help="Generates the assembler file")
group.add_argument("-t", "--tokens", action = "store_true", help="Generates the token list and display it on the terminal")
group.add_argument("-a", "--ast", action = "store_true", help="Generates the AST and display it on the terminal")

args = parser.parse_args()

try:
	raw_text = read_file(args.file)
except IOError as e: #excepción en caso de que el archivo no exista 
	raise SystemExit(e)

token_list = lexer(raw_text)
print(token_list)
try:
	ast = parser_f(token_list)
except IndexError as e:
	raise SystemExit("Syntax error, not enough tokens in the token list.")