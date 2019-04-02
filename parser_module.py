

def parser_f(token_list):
	function_parser(token_list)
	#añadir a AST (program  hijo -> function)
	if token_list:
		print("Syntax error: There are more elements after the function end.")

def function_parser(token_list):
	if token_list.pop(0) == 'keyword_int' and token_list:
		if token_list.pop(0) == 'keyword_main' and token_list:
			if token_list.pop(0) == 'parentheses_open' and token_list:
				if token_list.pop(0) == 'parentheses_close' and token_list:
					if token_list.pop(0) == 'bracket_open' and token_list:
						statement_parser(token_list)
						if token_list.pop(0) == 'bracket_close' and token_list:
							#añadir a AST (nombre -> function ; value -> main ; hijo-> statement)
							print("Succesful3")
						else:
							print("Syntax error, close bracket missing.")
					else:
						print("Syntax error, open bracket missing.")
				else:
					print("Syntax error, close parentheses missing.")
			else:
				print("Syntax error, open parentheses missing.")
		else:
			print("Syntax error, main function missing.")
	else:
		print("Syntax error, return type value missing.")

def statement_parser(token_list):
	if token_list.pop(0) == 'keyword_return':
		expression_parser(token_list)
		if token_list.pop(0) == 'semicolon' and token_list:
		##añadir a AST (nombre -> return, hijo -> expresion)
			print("Succesful2")
		else:
			print("Syntax error, semicolon missing after constant to finish return statment.")
	else:
		print("Syntax error, return keyword missing.")

def expression_parser(token_list):
	temp = token_list.pop(0)
	if tuple == type(temp) and token_list:
		#Añadir a AST (nombre -> constant, value: el valor del int)
		print("Succesful1")
	else:
		print("Syntax error, constant value missing.")

