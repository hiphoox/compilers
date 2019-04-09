
import sys  #porque esta en una carpeta de fuera
sys.path.append("..")

from code_generator import *
from lexer_module import *
from parser_module import *

"""  para checar si el codigo de ensamblador generado es igual al codigo definido hay que compararlo pero como puede recibir numeros 
	 de 0 en adelante, entonces hay que checar si el codigo definido para 2 es igual al codigo de cualquier otro numero entonces vamos 
	 a sustuir la primera parte del codigo, es decir la parte que esta antes del entero, la vamos a sustituir por espacios en blanco,
	 la siguiente funcion solo devuelve esa primera parte del codigo ensamblador  """
def ensambladorEsperado1(): 
	
	archivo = open("task1.txt", "r")

	plainText  = archivo.read()
	archivo.close()
	return plainText

	#esta funcion devuelve la segunda parte del ensamblador, o sea lo que esta despues del entero
def ensambladorEsperado2(): 


	
	archivo = open("task2.txt", "r")

	plainText  = archivo.read()
	archivo.close()
	return plainText

#abrimos la gramatica de la cual se va a generar el ensamblador, llamamos al lexer y los otros modulos que generan el arbol y el ensamblador
#sustituyes por espacios lo que esta antes del entero en el codigo y despues sustituyes lo que esta depues del entero 
#creas un objeto de una expresion regular para reconocer $ y enteros, en unknowninputs guardas lo que queda tras
#sustituir por espacios lo que resta en la cadena ensambladorGenerado, se supone que tras quitar la primera parte y la segunda del codigo
#entonces solo deberia quedar $entero y con la expresion regular ya deberia quedar vacia pero si vemos que en uknown_inputs hay algo entonces
#se regresa 0 para que el assert mande error
def assembler_spaces(ensambladorEsperado1, ensambladorEsperado2):
	archivo = open("stage_1/valid/spaces.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	arbolGenerado = parser_f(listaTokens)
	ensambladorGenerado= generator(arbolGenerado)
	ensambladorGenerado = ensambladorGenerado.replace(ensambladorEsperado1,"")
	ensambladorGenerado = ensambladorGenerado.replace(ensambladorEsperado2,"")
	#ensambladorGenerado = ensambladorGenerado + "ww"
	keywords = re.compile('[\$]+|[0-9]+')

	unknown_inputs = re.sub(keywords, '', ensambladorGenerado)

	if unknown_inputs.strip(): #to displaye the error in case of a failed lexical analysis
		return 0
	return 1

def assembler_return_2(ensambladorEsperado1,ensambladorEsperado2):
	archivo = open("stage_1/valid/return_2.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	arbolGenerado = parser_f(listaTokens)
	ensambladorGenerado= generator(arbolGenerado)
	ensambladorGenerado = ensambladorGenerado.replace(ensambladorEsperado1,"")
	ensambladorGenerado = ensambladorGenerado.replace(ensambladorEsperado2,"")

	#ensambladorGenerado = ensambladorGenerado + "ww"
	keywords = re.compile('[\$]+|[0-9]+')

	unknown_inputs = re.sub(keywords, '', ensambladorGenerado)

	if unknown_inputs.strip(): #to displaye the error in case of a failed lexical analysis
		return 0
	return 1


def assembler_multi_digit(ensambladorEsperado1,ensambladorEsperado2):
	archivo = open("stage_1/valid/multi_digit.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	arbolGenerado = parser_f(listaTokens)
	ensambladorGenerado= generator(arbolGenerado)
	ensambladorGenerado = ensambladorGenerado.replace(ensambladorEsperado1,"")
	ensambladorGenerado = ensambladorGenerado.replace(ensambladorEsperado2,"")

	#ensambladorGenerado = ensambladorGenerado + "ww"
	keywords = re.compile('[\$]+|[0-9]+')

	unknown_inputs = re.sub(keywords, '', ensambladorGenerado)

	if unknown_inputs.strip(): #to displaye the error in case of a failed lexical analysis
		return 0
	return 1

def assembler_no_newlines(ensambladorEsperado1,ensambladorEsperado2):
	archivo = open("stage_1/valid/no_newlines.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	arbolGenerado = parser_f(listaTokens)
	ensambladorGenerado= generator(arbolGenerado)
	ensambladorGenerado = ensambladorGenerado.replace(ensambladorEsperado1,"")
	ensambladorGenerado = ensambladorGenerado.replace(ensambladorEsperado2,"")

	#ensambladorGenerado = ensambladorGenerado + "ww"
	keywords = re.compile('[\$]+|[0-9]+')

	unknown_inputs = re.sub(keywords, '', ensambladorGenerado)

	if unknown_inputs.strip(): #to displaye the error in case of a failed lexical analysis
		return 0
	return 1

	
def assembler_newlines(ensambladorEsperado1,ensambladorEsperado2):
	archivo = open("stage_1/valid/newlines.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	arbolGenerado = parser_f(listaTokens)
	ensambladorGenerado= generator(arbolGenerado)
	ensambladorGenerado = ensambladorGenerado.replace(ensambladorEsperado1,"")
	ensambladorGenerado = ensambladorGenerado.replace(ensambladorEsperado2,"")

	#ensambladorGenerado = ensambladorGenerado + "ww"
	keywords = re.compile('[\$]+|[0-9]+')

	unknown_inputs = re.sub(keywords, '', ensambladorGenerado)

	if unknown_inputs.strip(): #to displaye the error in case of a failed lexical analysis
		return 0
	return 1

def assembler_return_0(ensambladorEsperado1,ensambladorEsperado2):
	archivo = open("stage_1/valid/return_0.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	arbolGenerado = parser_f(listaTokens)
	ensambladorGenerado= generator(arbolGenerado)
	ensambladorGenerado = ensambladorGenerado.replace(ensambladorEsperado1,"")
	ensambladorGenerado = ensambladorGenerado.replace(ensambladorEsperado2,"")

	#ensambladorGenerado = ensambladorGenerado + "ww"
	keywords = re.compile('[\$]+|[0-9]+')

	unknown_inputs = re.sub(keywords, '', ensambladorGenerado)

	if unknown_inputs.strip(): #to displaye the error in case of a failed lexical analysis
		return 0
	return 1



########################### INVALIDAS ########################### 

def assembler_no_space(ensambladorEsperado1,ensambladorEsperado2):
	archivo = open("stage_1/invalid/no_space.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	arbolGenerado = parser_f(listaTokens)
	ensambladorGenerado= generator(arbolGenerado)
	ensambladorGenerado = ensambladorGenerado.replace(ensambladorEsperado1,"")
	ensambladorGenerado = ensambladorGenerado.replace(ensambladorEsperado2,"")

	#ensambladorGenerado = ensambladorGenerado + "ww"
	keywords = re.compile('[\$]+|[0-9]+')

	unknown_inputs = re.sub(keywords, '', ensambladorGenerado)

	if unknown_inputs.strip(): #to displaye the error in case of a failed lexical analysis
		return 0
	return 1


	



