import re

def lexer(plaintext):
	keywords = re.compile('[a-zA-Z]+|[\{,\},\(,\),\;]|[0-9]+')

	unknown_inputs = re.sub(keywords, '', plaintext)
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
		elif (re.match(r'[0-9]+', token) is not None): #to detect integers
			token_list.append(tuple(['integer',int(token)]))
		else: #the unknown tokens would enter here
			unknown_inputs+= " " + token

	if unknown_inputs.strip(): #to displaye the error in case of a failed lexical analysis
		print("Lexical error, invalid input detected at file. List of unknown tokens: ")
		print(unknown_inputs.split())
		raise SystemExit()

	return (token_list)
