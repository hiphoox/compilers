import sys


sys.path.append("..")#porque esta en una carpeta de fuera
from lexer_module import *



def lista():
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

################### Pruebas de Nora  VALIDAS ################### 

"""si un token es distinto con el alguno de "lista esperada" pero dentro de ese token se 
se encuentra la palabra "integer" entonces significa que es un entero  y puede
ser distinto, dado que acepta todos los enteros nuestro compilador. Si el token distinto y no tiene
esa palabra entonces checa si es un operador definido en la lista de operadores. Esto es posible porque en el lexer 
si encuentra un numero lo etiqueta con la palabra integer. El elemento de la lista que 
tiene que tener la etiqueta integer es una tupla """


def compara(listaGenerada,listaEsperada):
	listaOperadores = ['negation' ,'bitwise_complement', 'logical_negation', 'addition', 'multiplication', 'division']
	y=0#para iterar lista esperada, la cual solo avanzara cuando haya un token igual en la lista recibida
	
	for x in range(0,len(listaGenerada)):
			
		#print("compara",listaEsperada[y],"con", listaGenerada[x] )
		
		if (listaEsperada[y] != listaGenerada[x]): #si un elemento no es el esperado puede ser un entero o un operador, si no es alguno de esos manda error ya que solo estos dos pueden ser de varios tipos

			encuentra  = "integer" in listaGenerada[x] #si el token distinto es un entero significa que no hay problema	
			
			if (encuentra == False):				
				for elemento in listaOperadores: #si no es un entero se comprueba que sea un operador
					if elemento == listaGenerada[x]: #si es un operador se guarda su valor
						operador=elemento;
						#print("operador", operador)
				if not elemento:	#tras recorrer la lista de posibles operadores, si la cadena elemento esta vacia significa que no hubo match con un posible operador y manda error
					#print("fallas")
					return 0 
			#else:
				#y=y+1#si es un entero entonces sigue iterando la lista esperada, solo no itera si es un operador
		else:
			y=y+1 #si son iguales sigue iterando la lista esperada
	#print("exito")	
	return 1


###############################   STAGE 1   ############################### 

def lexer_return_2(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_1/valid/return_2.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_multi_digit(listaEsperada): 
	archivo = open("stage_1/valid/multi_digit.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_spaces(listaEsperada): 
	archivo = open("stage_1/valid/spaces.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_newlines(listaEsperada): 
	archivo = open("stage_1/valid/newlines.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_no_newlines(listaEsperada): 
	archivo = open("stage_1/valid/no_newlines.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_return_0(listaEsperada): 
	archivo = open("stage_1/valid/return_0.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

#dado que usamos expresiones regulares, podemos reconocer tokens aun sin espacio

def lexer_no_space(listaEsperada): 
	archivo = open("stage_1/invalid/no_space.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0
###############################   STAGE 2   ############################### 

def lexer_nested_ops_2(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
			
	archivo = open("stage_2/valid/nested_ops_2.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

	


def lexer_bitwise_zero(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_2/valid/bitwise_zero.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_not_zero(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_2/valid/not_zero.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_bitwise(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_2/valid/bitwise.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_neg(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_2/valid/neg.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_nested_ops(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_2/valid/nested_ops.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_not_five(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_2/valid/not_five.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

###############################   STAGE 3   ############################### 
def lexer_add(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_3/valid/add.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_associativity(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_3/valid/associativity.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_associativity_2(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_3/valid/associativity_2.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_div(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_3/valid/div.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_mult(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_3/valid/mult.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_parens(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_3/valid/parens.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_precedence(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_3/valid/precedence.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_sub(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_3/valid/sub.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_sub_neg(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_3/valid/sub_neg.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_unop_add(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_3/valid/unop_add.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0

def lexer_unop_parens(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("stage_3/valid/unop_parens.c", "r")
	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	plainText = archivo.close()

	if compara(listaTokens,listaEsperada):
		return 1
	else:
		return 0
#las pruebas devuelven cero si fallan y 1 si pasan


