import sys  #porque esta en una carpeta de fuera
sys.path.append("..")

from parser_module import *
from lexer_module import *

################################## INVALIDAS ################################## 
def arbol_no_brace():
	archivo = open("stage_1/invalid/no_brace.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	try:
		ast=parser_f(token_list)
	except:
		return 0
	return 1

def arbol_missing_retval():
	archivo = open("stage_1/invalid/missing_retval.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	try:
		ast=parser_f(token_list)
	except:
		return 0
	return 1


def arbol_missing_paren():
	archivo = open("stage_1/invalid/missing_paren.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	try:
		ast=parser_f(token_list)
	except:
		return 0
	return 1

def arbol_no_semicolon():
	archivo = open("stage_1/invalid/no_semicolon.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	try:
		ast=parser_f(token_list)
	except:
		return 0
	return 1

#manda la excepcion el Lexer
def arbol_wrong_case():
	archivo = open("stage_1/invalid/wrong_case.c", "r")

	plainText  = archivo.read()
	
	try:
		token_list = lexer(plainText)
	except:
		return 0
	return 1






	
