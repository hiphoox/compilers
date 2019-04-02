
def parser_f(token_list):
	function_parser(token_list)
	#añadir a AST (program  hijo -> function)
	if token_list:
		print("Syntax error: There are more elements after the function end.")

def function_parser(token_list):
	if token_list.pop(0) != 'keyword_int':  raise SystemExit("Syntax error, return type value missing.")
	if token_list.pop(0) != 'keyword_main':  raise SystemExit("Syntax error, main function missing.")
	if token_list.pop(0) != 'parentheses_open':  raise SystemExit("Syntax error, open parentheses missing.")
	if token_list.pop(0) != 'parentheses_close':  raise SystemExit("Syntax error, close parentheses missing.")
	statement_parser(token_list) if token_list.pop(0) == 'bracket_open' else raiser(SystemExit("Syntax error, open bracket missing."))
	print("Succesful3") if token_list.pop(0) == 'bracket_close' else  raiser(SystemExit("Syntax error, close bracket missing."))
		#añadir a AST (nombre -> function ; value -> main ; hijo-> statement), por el momento print será un placeholder

def statement_parser(token_list):
	expression_parser(token_list) if token_list.pop(0) == 'keyword_return' else raiser(SystemExit("Syntax error, return keyword missing."))
	print("Succesful2") if token_list.pop(0) == 'semicolon' else raiser(SystemExit("Syntax error, semicolon missing after constant to finish return statment."))
		##añadir a AST (nombre -> return, hijo -> expresion), por el momento print será un placeholder		

def expression_parser(token_list):
	temp = token_list.pop(0)
	print("Succesful1") if tuple == type(temp) else raiser(SystemExit("Syntax error, constant value missing."))
		#Añadir a AST (nombre -> constant, value: el valor del int, por el momento print será un placeholder

def raiser(exception) : raise exception