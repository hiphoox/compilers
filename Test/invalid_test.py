import sys  #porque esta en una carpeta de fuera
sys.path.append("..")

from parser_module import *
from lexer_module import *
from lexer_test import *


################################## INVALIDAS ################################## 
def arbol_no_brace():
	archivo = open("stage_1/invalid/no_brace.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	archivo.close()
	try:
		ast=parser_f(token_list)
	except:
		return 0
	return 1

def arbol_missing_retval():
	archivo = open("stage_1/invalid/missing_retval.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	archivo.close()
	try:
		ast=parser_f(token_list)
	except:
		return 0
	return 1


def arbol_missing_paren():
	archivo = open("stage_1/invalid/missing_paren.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	archivo.close()
	try:
		ast=parser_f(token_list)
	except:
		return 0
	return 1

def arbol_no_semicolon():
	archivo = open("stage_1/invalid/no_semicolon.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	archivo.close()
	try:
		ast=parser_f(token_list)
	except:
		return 0
	return 1

#manda la excepcion el Lexer porque no puede generar una lista con el token RETURN
def arbol_wrong_case():
	archivo = open("stage_1/invalid/wrong_case.c", "r")

	plainText  = archivo.read()
	archivo.close()
	try:
		token_list = lexer(plainText)
	except:
		return 0
	return 1

def arbol_missing_const():
	archivo = open("stage_2/invalid/missing_const.c", "r")

	plainText  = archivo.read()
	archivo.close()
	try:
		token_list = lexer(plainText)
	except:
		return 1
	return 0

def arbol_missing_semicolon():
	archivo = open("stage_2/invalid/missing_semicolon.c", "r")

	plainText  = archivo.read()
	archivo.close()
	try:
		token_list = lexer(plainText)
	except:
		return 1
	return 0

def arbol_nested_missing_const():
	archivo = open("stage_2/invalid/nested_missing_const.c", "r")

	plainText  = archivo.read()
	archivo.close()
	try:
		token_list = lexer(plainText)
	except:
		return 1
	return 0

def arbol_wrong_order():
	archivo = open("stage_2/invalid/missing_const.c", "r")

	plainText  = archivo.read()
	archivo.close()
	try:
		token_list = lexer(plainText)
	except:
		return 1
	return 0
"""Desde aqui empiezan las invalidas para el Lexer, si se regresa un cero quiere decir que la lista generada es distinta a la 
	lista esperada, por lo que esa prueba es invalida. Si se regresa un 1 quiere decir que la prueba invalida generó una lista
	igual a la esperada lo cual no es correcto"""

def lista1():
	lista = ['keyword_int',
			 'keyword_main',
			 'parentheses_open',
			 'parentheses_close',
			 'bracket_open',
			 'keyword_return',
			 ('integer',2),
			 'semicolon',
			 'bracket_close'
			]


	return lista

def lexer_missing_paren(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_1/invalid/missing_paren.c", "r")

	plainText  = archivo.read()
	#print(plainText)
	listaTokens = lexer(plainText)
	#print("ret 2 ",listaTokens)
	archivo.close()
	for x in range(0,len(listaEsperada)):

		if (listaEsperada[x] != listaTokens[x]):
   			#print("\nPrueba lexer_missing_paren.c exitosa")
   			return 0
   			
	return 1		
	#print("\nPrueba lexer_missing_paren.c fallida")


def lexer_missing_retval(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_1/invalid/missing_retval.c", "r")

	plainText  = archivo.read()
	#print(plainText)
	listaTokens = lexer(plainText)
	#print("ret 2 ",listaTokens)
	archivo.close()
	for x in range(0,len(listaEsperada)):

		if (listaEsperada[x] != listaTokens[x]):
   			#print("\nPrueba lexer_missing_retval.c exitosa") #quiere decir que la lista es distinta a la esperada, por ese la prueba invalida cumple
   			return 0
   			
	return 1		
	#print("\nPrueba lexer_missing_retval.c fallida")

def lexer_no_brace(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_1/invalid/no_brace.c", "r")

	plainText  = archivo.read()
	#print(plainText)
	listaTokens = lexer(plainText)
	#print("ret 2 ",listaTokens)
	archivo.close()
	for x in range(0,len(listaEsperada)):

		if (listaEsperada[x] != listaTokens[x]):
   			#print("\nPrueba lexer_no_brace.c exitosa") #quiere decir que la lista es distinta a la esperada, por ese la prueba invalida cumple
   			return 0
   			
	return 1		
	#print("\nPrueba lexer_no_brace.c fallida")

def lexer_no_semicolon(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_1/invalid/no_semicolon.c", "r")

	plainText  = archivo.read()
	#print(plainText)
	listaTokens = lexer(plainText)
	#print("ret 2 ",listaTokens)
	archivo.close()
	for x in range(0,len(listaEsperada)):

		if (listaEsperada[x] != listaTokens[x]):
   			#print("\nPrueba lexer_no_semicolon.c exitosa") #quiere decir que la lista es distinta a la esperada, por ese la prueba invalida cumple
   			return 0
   			
	return 1		
	#print("\nPrueba lexer_no_semicolon.c fallida")

def lexer_wrong_case(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_1/invalid/wrong_case.c", "r")

	plainText  = archivo.read()
	#print(plainText)
	listaTokens = lexer(plainText)
	archivo.close()
	#print("ret 2 ",listaTokens)
	for x in range(0,len(listaEsperada)):

		if (listaEsperada[x] != listaTokens[x]):
   			#print("\nPrueba lexer_wrong_case.c exitosa") #quiere decir que la lista es distinta a la esperada, por ese la prueba invalida cumple
   			return 0
   			
	return 1		
	#print("\nPrueba lexer_wrong_case.c fallida")



