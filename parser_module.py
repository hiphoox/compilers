from treelib import Node, Tree

def parser_f(token_list):
	ast_list = []
	function_parser(token_list, ast_list)
	ast = Tree()
	ast.create_node('Program', 'prog') #to create the first node of the AST
	#añadir a AST (program  hijo -> function)
	if token_list: raise SystemExit("Syntax error: There are more elements after the function end.")
	
	for leaf in reversed(ast_list): #to create the rest of the nodes of the tree from the list
		if 'Constant' in leaf[0]: ast.create_node(leaf[0], leaf[1], parent = 'expr', data = leaf[2][1])
		if 'Expression' in leaf[0]: ast.create_node(leaf[0], leaf[1], parent = 'func', data = leaf[2])
		if 'Function' in leaf[0]: ast.create_node(leaf[0], leaf[1], parent = 'prog', data = leaf[2])
	return(ast)

def function_parser(token_list, ast_list):
	if token_list.pop(0) != 'keyword_int':  raise SystemExit("Syntax error, return type value missing.")
	if token_list.pop(0) != 'keyword_main':  raise SystemExit("Syntax error, main function missing.")
	if token_list.pop(0) != 'parentheses_open':  raise SystemExit("Syntax error, open parentheses missing.")
	if token_list.pop(0) != 'parentheses_close':  raise SystemExit("Syntax error, close parentheses missing.")
	statement_parser(token_list, ast_list) if token_list.pop(0) == 'bracket_open' else raiser(SystemExit("Syntax error, open bracket missing."))
	temporal_token = token_list.pop(0) 
	ast_list.append(['Function:main','func',temporal_token]) if temporal_token == 'bracket_close' else  raiser(SystemExit("Syntax error, close bracket missing."))
		#añadir a AST (nombre -> function ; value -> main ; hijo-> statement), por el momento print será un placeholder
		

def statement_parser(token_list, ast_list):
	expression_parser(token_list, ast_list) if token_list.pop(0) == 'keyword_return' else raiser(SystemExit("Syntax error, return keyword missing."))
	temporal_token = token_list.pop(0) 
	ast_list.append(['Expression:return','expr',temporal_token]) if temporal_token == 'semicolon' else raiser(SystemExit("Syntax error, semicolon missing after constant to finish return statment."))
		##añadir a AST (nombre -> return, hijo -> expresion), por el momento print será un placeholder		

def expression_parser(token_list, ast_list):
	temporal_token = token_list.pop(0)
	ast_list.append(['Constant:'+str(temporal_token[1]),'const',temporal_token]) if tuple == type(temporal_token) else raiser(SystemExit("Syntax error, constant value missing."))
		#Añadir a AST (nombre -> constant, value: el valor del int, por el momento print será un placeholder

def raiser(exception) : raise exception #to raise exceptions as a single expression