
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
	plainText = archivo.close()
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
	plainText = archivo.close()
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
	plainText = archivo.close()
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
	plainText = archivo.close()
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
	plainText = archivo.close()
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
	plainText = archivo.close()

	#ensambladorGenerado = ensambladorGenerado + "ww"
	keywords = re.compile('[\$]+|[0-9]+')

	unknown_inputs = re.sub(keywords, '', ensambladorGenerado)

	if unknown_inputs.strip(): #to displaye the error in case of a failed lexical analysis
		return 0
	return 1

########################### STAGE 2 ########################### 
########################### ########################### ########################### 
########################### ########################### ########################### 
########################### ########################### ########################### 

#funcion que obtiene el ensamblador esperado que ya se encuentra escrito en un archivo en la carpeta assembler_test
def ensamblador_esperado_stage2(direccion):
	f=open(direccion)
	archivo=f.read()
	#print(archivo)
	f.close()
	return archivo

def assembler_bitwise():
	archivo = open("stage_2/valid/bitwise.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()

	assem=assembler_generator(ast)

	

	esperado = ensamblador_esperado_stage2("assembler_test/bitwise.txt")

	#print(">>>>",assem)
	#print(">>>>",esperado)

	if(assem==esperado):
		return 1
	else:
		return 0


def assembler_nested_ops():
	archivo = open("stage_2/valid/nested_ops.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()

	assem=assembler_generator(ast)

	

	esperado = ensamblador_esperado_stage2("assembler_test/nested_ops.txt")

	#print(">>>>",assem)
	#print(">>>>",esperado)

	if(assem==esperado):
		return 1
	else:
		return 0


def assembler_not_zero():
	archivo = open("stage_2/valid/not_zero.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()

	assem=assembler_generator(ast)

	

	esperado = ensamblador_esperado_stage2("assembler_test/not_zero.txt")

	#print(">>>>",assem)
	#print(">>>>",esperado)

	if(assem==esperado):
		return 1
	else:
		return 0


def assembler_not_five():
	archivo = open("stage_2/valid/not_five.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()

	assem=assembler_generator(ast)
	

	esperado = ensamblador_esperado_stage2("assembler_test/not_five.txt")

	#print(">>>>",assem)
	#print(">>>>",esperado)

	if(assem==esperado):
		return 1
	else:
		return 0


def assembler_bitwise_zero():
	archivo = open("stage_2/valid/bitwise_zero.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()

	assem=assembler_generator(ast)
	

	esperado = ensamblador_esperado_stage2("assembler_test/bitwise_zero.txt")

	#print(">>>>",assem)
	#print(">>>>",esperado)

	if(assem==esperado):
		return 1
	else:
		return 0

def assembler_neg():
	archivo = open("stage_2/valid/neg.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()

	assem=assembler_generator(ast)
	

	esperado = ensamblador_esperado_stage2("assembler_test/neg.txt")

	#print(">>>>",assem)
	#print(">>>>",esperado)

	if(assem==esperado):
		return 1
	else:
		return 0
def assembler_nested_ops_2():
	archivo = open("stage_2/valid/nested_ops_2.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()

	assem=assembler_generator(ast)

	

	esperado = ensamblador_esperado_stage2("assembler_test/nested_ops_2.txt")

	#print(">>>>",assem)
	#print(">>>>",esperado)

	if(assem==esperado):
		return 1
	else:
		return 0





########################### INVALIDAS ########################### 

def assembler_no_space(ensambladorEsperado1,ensambladorEsperado2):
	archivo = open("stage_1/invalid/no_space.c", "r")

	plainText  = archivo.read()
	listaTokens = lexer(plainText)
	arbolGenerado = parser_f(listaTokens)
	ensambladorGenerado= generator(arbolGenerado)
	ensambladorGenerado = ensambladorGenerado.replace(ensambladorEsperado1,"")
	ensambladorGenerado = ensambladorGenerado.replace(ensambladorEsperado2,"")
	plainText = archivo.close()
	#ensambladorGenerado = ensambladorGenerado + "ww"
	keywords = re.compile('[\$]+|[0-9]+')

	unknown_inputs = re.sub(keywords, '', ensambladorGenerado)

	if unknown_inputs.strip(): #to displaye the error in case of a failed lexical analysis
		return 0
	return 1


	



