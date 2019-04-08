from lexer_module import * 

def lista():
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

################### Pruebas de Nora  VALIDAS ################### 

"""si un token es distinto con el alguno de "lista esperada" pero dentro de ese token se 
se encuentra la palabra "integer" entonces significa que es un entero y puede
ser distinto, dado que acepta todos los enteros nuestro compilador. Si el token distinto y no tiene
esa palabra entonces sí manda que hay un error. Esto es posible porque en el lexer 
si encuentra un numero lo etiqueta con la palabra integer. El elemento de la lista que 
tiene que tener la etiqueta integer es una tupla """

	
def lexer_return_2(listaEsperada):   #comparar lista fija con lista de tokens recibida con la gramatica original
	
	archivo = open("test_nora/stage_1/valid/return_2.c", "r")

	plainText  = archivo.read()
	#print(plainText)
	listaTokens = lexer(plainText)
	#print("ret 2 ",listaTokens)
	for x in range(0,len(listaEsperada)):

		if (listaEsperada[x] != listaTokens[x]):
   			#print("\nPrueba return_2 fallida")
   			return 0
   			
	return 1		
	#print("\nPrueba return_2 exitosa")
   	
		
		
def lexer_multi_digit(listaEsperada): 
	archivo = open("test_nora/stage_1/valid/multi_digit.c", "r")

	plainText  = archivo.read()
	#print(plainText)
	listaTokens = lexer(plainText)
	for x in range(0,len(listaEsperada)):

		if (listaEsperada[x] != listaTokens[x]):
   		
			encuentra  = "integer" in listaTokens[x]			

			if (encuentra == False):
   				#print("\nPrueba multi_digit fallida")
   				return 0
	return 1			
	#print("\nPrueba multi_digit exitosa")  #todos los tokens fueron iguales
   	

def lexer_spaces(listaEsperada): 
	archivo = open("test_nora/stage_1/valid/spaces.c", "r")

	plainText  = archivo.read()
	#print(plainText)
	listaTokens = lexer(plainText)
	for x in range(0,len(listaEsperada)):

		if (listaEsperada[x] != listaTokens[x]):
   		
			encuentra  = "integer" in listaTokens[x]			
			if (encuentra == False):
   			#	print("\nPrueba spaces fallida")
   				return 0
	return 1		
	#print("\nPrueba spaces exitosa")  #todos los tokens fueron iguales

def lexer_newlines(listaEsperada): 
	archivo = open("test_nora/stage_1/valid/newlines.c", "r")

	plainText  = archivo.read()
	#print(plainText)
	listaTokens = lexer(plainText)
	for x in range(0,len(listaEsperada)):

		if (listaEsperada[x] != listaTokens[x]):
   		
			encuentra  = "integer" in listaTokens[x]			
			if (encuentra == False):
   				#print("\nPrueba newlines fallida") 
   				return 0
	return 1	   			
	#print("\nPrueba newlines exitosa")  #todos los tokens fueron iguales

def lexer_no_newlines(listaEsperada): 
	archivo = open("test_nora/stage_1/valid/no_newlines.c", "r")

	plainText  = archivo.read()
	#print(plainText)
	listaTokens = lexer(plainText)
	for x in range(0,len(listaEsperada)):

		if (listaEsperada[x] != listaTokens[x]):
   		
			encuentra  = "integer" in listaTokens[x]			
			if (encuentra == False):
   				#print("\nPrueba no_newlines fallida") 
   				return 0
	return 1	   			
	#print("\nPrueba no_newlines exitosa")  #todos los tokens fueron iguales

def lexer_return_0(listaEsperada): 
	archivo = open("test_nora/stage_1/valid/return_0.c", "r")

	plainText  = archivo.read()
	#print(plainText)
	listaTokens = lexer(plainText)
	for x in range(0,len(listaEsperada)):

		if (listaEsperada[x] != listaTokens[x]):
   		
			encuentra  = "integer" in listaTokens[x]			
			if (encuentra == False):
   				#print("\nPrueba return_0 fallida")
   				return 0
	return 1	   			
	#print("\nPrueba return_0 exitosa")  #todos los tokens fueron iguales

def lexer_no_space(listaEsperada): 
	archivo = open("test_nora/stage_1/invalid/no_space.c", "r")

	plainText  = archivo.read()
	#print(plainText)
	listaTokens = lexer(plainText)
	#print(listaTokens)
	for x in range(0,len(listaEsperada)):

		if (listaEsperada[x] != listaTokens[x]):
   		
			encuentra  = "integer" in listaTokens[x]			
			if (encuentra == False):
   				#print("\nPrueba return_0 fallida")
   				return 0
	return 1	   			
	#print("\nPrueba return_0 exitosa")  #todos los tokens fueron iguales




#dado que usamos expresiones regulares, podemos reconocer tokens aun sin espacio




