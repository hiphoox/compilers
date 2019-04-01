import re

def lexer(plaintext):
	keywords = re.compile('[a-zA-Z]+|[\{,\},\(,\),\;]|[0-9]+')
	
	unknown_inputs = re.sub(keywords, '', plaintext)
	if unknown_inputs.strip(): #to detect the existence unknown tokens
		print("Invalid input detected at file. List of unknown tokens: ")
		print(unknown_inputs.split())
		raise SystemExit() 

	raw_tokens = re.findall(keywords, plaintext)
	token_list = []
	for token in raw_tokens:
		if token == 'main':
			token_list.append('keyword_main')
		elif token == 'return':
			token_list.append('keyword_return')
		elif token == 'int':
			token_list.append('keyword_int')
		elif token == '(':
			token_list.append('parentheses_open')
		elif token == ')':
			token_list.append('parentheses_close')
		elif token == '{':
			token_list.append('bracket_open')
		elif token == '}':
			token_list.append('bracket_close')
		elif token == ';':
			token_list.append('semicolon')
		else:
			token_list.append(tuple(['integer',int(token)]))
	
	return (token_list)
