
import sys  #porque esta en una carpeta de fuera
sys.path.append("..")

from parser_module import *
from lexer_module import *



def arbolEsperado():

	ast_test = Tree()
	ast_test.create_node('Program', 'prog')
	ast_test.create_node('Function:main','func', parent = 'prog', data = 'bracket_close')
	ast_test.create_node('Expression:return','expr', parent = 'func', data = 'semicolon')
	ast_test.create_node('Constant:2','const', parent = 'expr', data = 2)

	#print(ast_test)
	return ast_test

def arbol_return_2(ast_test):
	archivo = open("stage_1/valid/return_2.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)

	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf).tag != ast_test.get_node(leaf).tag:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			#print("Es igual")
			return 1
		else:
			#print("Es diferente")
			return 0
def arbol_spaces(ast_test):
	archivo = open("stage_1/valid/spaces.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)

	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf).tag != ast_test.get_node(leaf).tag:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			#print("Es igual")
			return 1
		else:
			#print("Es diferente")
			return 0
def arbol_newlines(ast_test):
	archivo = open("stage_1/valid/newlines.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf).tag != ast_test.get_node(leaf).tag:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			#print("Es igual")
			return 1
		else:
			#print("Es diferente")
			return 0

def arbol_no_newlines(ast_test):
	archivo = open("stage_1/valid/no_newlines.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf).tag != ast_test.get_node(leaf).tag:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			#print("Es igual")
			return 1
		else:
			#print("Es diferente")
			return 0
def arbol_return_0(ast_test):
	archivo = open("stage_1/valid/return_0.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf).tag != ast_test.get_node(leaf).tag:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			#print("Es igual")
			return 1
		else:
			#print("Es diferente")
			return 0
def arbol_multi_digit(ast_test):
	archivo = open("stage_1/valid/multi_digit.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf).tag != ast_test.get_node(leaf).tag:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			#print("Es diferente")
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			#print("Es igual")
			return 1
		else:
			#print("Es diferente")
			return 0


################################## INVALIDAS ################################## 
"""def arbol_no_brace():
	archivo = open("stage_1/invalid/no_brace.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)"""