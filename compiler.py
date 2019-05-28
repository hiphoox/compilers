import sys
import argparse
from file_clean import *
from lexer_module import *
from parser_module import *
from code_generator import *
from linker_module import linker

parser = argparse.ArgumentParser()
group = parser.add_mutually_exclusive_group()
parser.add_argument("file", type=str, help="name of the C file")
parser.add_argument("-o", "--output", type=str,
                    help="Write output to <OUTPUT>")
group.add_argument("-s", "--ensamblador", action="store_true",
                   help="Generates the assembler file")
group.add_argument("-t", "--tokens", action="store_true",
                   help="Generates the token list and display it on the terminal")
group.add_argument("-a", "--ast", action="store_true",
                   help="Generates the AST and display it on the terminal")

args = parser.parse_args()

try:
    raw_text = read_file(args.file)
except IOError as e:  # excepción en caso de que el archivo no exista
    raise SystemExit(e)
##Lexical analysis segment##
token_list = lexer(raw_text)
if token_list == 'failed':
    raise SystemExit()
if args.tokens:
    for i in range(0,len(token_list)):
        print(str(i+1) + ") "+ str(token_list[i]))
    sys.exit("Token list succesfully generated")
###-----###
##Syntax analysys segment##
try:
    as_tree = parser_f(token_list)
except IndexError as e:
    raise SystemExit("Syntax error, not enough tokens in the token list.")
if args.ast:
    print(as_tree)
    sys.exit("AST succesfully generated")
###-----###
##Code generator segment##
assembly = generator(as_tree)
###-----###
##Creating an assembler file for the linker##
try:
    assembly_dir = args.file.replace(".c", ".asm")
    with open(assembly_dir, 'w') as asm:
        asm.write(assembly)
except:
    raise SystemExit(e)
if args.ensamblador:
    sys.exit("Assembly succesfully generated")
##Linker section##
##Calling the linker##
if args.output:
    linker(assembly_dir, os.path.dirname(args.file)+"/"+args.output)
else:
    linker(assembly_dir, args.file.replace(".c", ".o"))
print("Program succesfully generated!")
print("Your output file is at: "+ args.file.replace(".c", ".o"))
###------###
