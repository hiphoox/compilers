
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
	plainText = archivo.close()

	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0
def arbol_spaces(ast_test):
	archivo = open("stage_1/valid/spaces.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()

	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0
def arbol_newlines(ast_test):
	archivo = open("stage_1/valid/newlines.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_no_newlines(ast_test):
	archivo = open("stage_1/valid/no_newlines.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0
def arbol_return_0(ast_test):
	archivo = open("stage_1/valid/return_0.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0
def arbol_multi_digit(ast_test):
	archivo = open("stage_1/valid/multi_digit.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0
####################Stage 2############################
def arbol_bitwise(ast_test):
	archivo = open("stage_2/valid/bitwise.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_bitwise_zero(ast_test):
	archivo = open("stage_2/valid/bitwise_zero.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_neg(ast_test):
	archivo = open("stage_2/valid/neg.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_nested_ops(ast_test):
	archivo = open("stage_2/valid/nested_ops.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_nested_ops_2(ast_test):
	archivo = open("stage_2/valid/nested_ops_2.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_not_five(ast_test):
	archivo = open("stage_2/valid/not_five.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_not_zero(ast_test):
	archivo = open("stage_2/valid/not_zero.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

####################Stage 3############################
def arbol_add(ast_test):
	archivo = open("stage_3/valid/add.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_associativity(ast_test):
	archivo = open("stage_3/valid/associativity.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_associativity_2(ast_test):
	archivo = open("stage_3/valid/associativity_2.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_div(ast_test):
	archivo = open("stage_3/valid/div.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_mult(ast_test):
	archivo = open("stage_3/valid/mult.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_parens(ast_test):
	archivo = open("stage_3/valid/parens.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_precedence(ast_test):
	archivo = open("stage_3/valid/precedence.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_sub(ast_test):
	archivo = open("stage_3/valid/sub.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_sub_neg(ast_test):
	archivo = open("stage_3/valid/sub_neg.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_unop_add(ast_test):
	archivo = open("stage_3/valid/unop_add.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0

def arbol_unop_parens(ast_test):
	archivo = open("stage_3/valid/unop_parens.c", "r")

	plainText  = archivo.read()
	token_list = lexer(plainText)
	ast=parser_f(token_list)
	plainText = archivo.close()
	#print(ast)
	node_list = ast.is_branch('func')
	#print(node_list)
	for leaf in node_list:
		if ast.get_node(leaf) != ast_test.get_node(leaf):
			return 1
		if ast.get_node(leaf).identifier != ast_test.get_node(leaf).identifier:
			return 0
		if ast.get_node(leaf).bpointer != ast_test.get_node(leaf).bpointer:
			return 0
		if ast.get_node(leaf).data == ast_test.get_node(leaf).data:
			return 1
		else:
			return 0
