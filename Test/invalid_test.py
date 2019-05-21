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


##############################################Para la semana 2 STAGE 2 INVALID ##################################################

def lista2():
	lista = ['keyword_int',
			 'keyword_main',
			 'parentheses_open',
			 'parentheses_close',
			 'bracket_open',
			 'keyword_return',
			 #('integer',2),
			 'semicolon',
			 'bracket_close'
			]


	return lista

"""si un token es distinto con el alguno de "lista esperada" pero dentro de ese token se 
se encuentra la palabra "integer" entonces significa que es un entero  y puede
ser distinto, dado que acepta todos los enteros nuestro compilador. Si el token distinto y no tiene
esa palabra entonces checa si es un operador definido en la lista de operadores. Esto es posible porque en el lexer 
si encuentra un numero lo etiqueta con la palabra integer. El elemento de la lista que 
tiene que tener la etiqueta integer es una tupla. Igual se verifica que antes de un operador unitario no exista un entero
y debe existir almenos una constante en la lista """
def lexer_invalid(listaGenerada,listaEsperada):
	listaOperadores = ['negation' ,'bitwise_complement', 'logical_negation', 'addition', 'multiplication', 'division']
	y=0#para iterar lista esperada, la cual solo avanzara cuando haya un token igual en la lista recibida
	numero=0#para ver si en el la lista hay un entero o no
	entero=0 
	for x in range(0,len(listaGenerada)):
		operador=False
		#print("compara",listaEsperada[y],"con", listaGenerada[x] )
		entero  = "integer" in listaGenerada[x] #debe haber almenos una constante
		if entero == True:
			numero =1
		if (listaEsperada[y] != listaGenerada[x]): #si un elemento no es el esperado puede ser un entero o un operador, si no es alguno de esos manda error ya que solo estos dos pueden ser de varios tipos

			encuentra  = "integer" in listaGenerada[x] #si el token distinto es un entero significa que no hay problema	
			
			if (encuentra == False):	
				
				for elemento in listaOperadores: #si no es un entero se comprueba que sea un operador
					if elemento == listaGenerada[x]: #si es un operador se guarda su valor
						operador=elemento;
						#print("operador", operador)
						orden=	"integer" in listaGenerada[x-1]	#si hay un operador el anterior en la lista no debe ser un entero
						if orden == True:
							#print("orden")
							return 0
						
				if operador== False:	#tras recorrer la lista de posibles operadores, si la cadena elemento esta vacia significa que no hubo match con un posible operador y manda error
					#print("distinta",listaEsperada[y],"con", listaGenerada[x] )
					return 0 

				
		else:
			y=y+1 #si son iguales sigue iterando la lista esperada
	
	if numero==0:
		#print("no hay entero")
		return 0#significa que en la lista de tokens no habia una constante
	#print("numero",numero)
	return 1


def lexer_stage2_missing_const(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_2/invalid/missing_const.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if lexer_invalid(listaTokens,listaEsperada):
		return 1
	else:
		return 0
def lexer_wrong_order(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_2/invalid/wrong_order.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if lexer_invalid(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_stage2_missing_semicolon(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_2/invalid/missing_semicolon.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if lexer_invalid(listaTokens,listaEsperada):
		return 1
	else:
		return 0
def lexer_nested_missing_const(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_2/invalid/nested_missing_const.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if lexer_invalid(listaTokens,listaEsperada):
		return 1
	else:
		return 0

"""
##############################################Para la semana 3 STAGE 3 INVALID ##################################################

def lista3():
	lista = ['keyword_int',
			 'keyword_main',
			 'parentheses_open',
			 'parentheses_close',
			 'bracket_open',
			 'keyword_return',
			 #('integer',2),
			 'semicolon',
			 'bracket_close'
			]


	return lista






#si un token es distinto con el alguno de "lista esperada" pero dentro de ese token se 
#se encuentra la palabra "integer" entonces significa que es un entero  y puede
#ser distinto, dado que acepta todos los enteros nuestro compilador. Si el token distinto y no tiene
#esa palabra entonces checa si es un operador definido en la lista de operadores. Esto es posible porque en el lexer 
#si encuentra un numero lo etiqueta con la palabra integer. El elemento de la lista que 
#tiene que tener la etiqueta integer es una tupla. Igual se verifica que haya una constante antes y despues de un operador binario
#y que no exista un parentesis despues de un entero 
def lexerInvalid_3(listaGenerada,listaEsperada):
	listaOperadores = ['negation' ,'bitwise_complement', 'logical_negation', 'addition', 'multiplication', 'division']
	binarios ='addition multiplication division'
	y=0#para iterar lista esperada, la cual solo avanzara cuando haya un token igual en la lista recibida
	
	for x in range(0,len(listaGenerada)):

		if "parentheses_open" in listaGenerada[x]:#no debe haber un entero antes de un parentesis
			if "integer" in listaGenerada[x-1]:
				#print("entero antes del parentesis")
				return 0

		operador=False	
		#print("compara",listaEsperada[y],"con", listaGenerada[x] )
		
		if (listaEsperada[y] != listaGenerada[x]): #si un elemento no es el esperado puede ser un entero o un operador, si no es alguno de esos manda error ya que solo estos dos pueden ser de varios tipos

			encuentra  = "integer" in listaGenerada[x] #si el token distinto es un entero significa que no hay problema	
			
			if (encuentra == False):				
				for elemento in listaOperadores: #si no es un entero se comprueba que sea un operador
					if elemento == listaGenerada[x]: #si es un operador se guarda su valor
						if elemento in binarios: #si es un operador binario su anterior y siguiente debe se un numero
							const1=	"integer" in listaGenerada[x-1]
							const2= "integer" in listaGenerada[x+1]
							if const1 == False or const2 == False:
								#print("falta entero en operador binario")
								return 0
						operador=elemento;
						#print("operador", operador)
				if  operador==False:	#tras recorrer la lista de posibles operadores, si la cadena elemento esta vacia significa que no hubo match con un posible operador y manda error
					#print("distinto",listaEsperada[y],"con", listaGenerada[x] )
					return 0 
			

				
		else:
			y=y+1 #si son iguales sigue iterando la lista esperada
	#print("exito")	
	return 1




def lexer_stage3_no_semicolon(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_3/invalid/no_semicolon.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if lexerInvalid_3(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_missing_second_op(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_3/invalid/missing_second_op.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if lexerInvalid_3(listaTokens,listaEsperada):
		return 1
	else:
		return 0
def lexer_malformed_paren(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_3/invalid/malformed_paren.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if lexerInvalid_3(listaTokens,listaEsperada):
		return 1
	else:
		return 0
def lexer_missing_first_op(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_3/invalid/missing_first_op.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if lexerInvalid_3(listaTokens,listaEsperada):
		return 1
	else:
		return 0
"""


