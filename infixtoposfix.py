class Conversion: 
	
	def __init__(self, capacity): 
		self.top = -1
		self.capacity = capacity 
		# This array is used a stack 
		self.array = [] 
		# Precedence setting 
		self.output = [] 
		self.precedence = {'addition_bin':0, 'negation':1, 'bitwise_complement': 1, 'logical_negation': 1, 'negation_bin':0 ,'multiplication':2, 'division':2} 
	
	def isEmpty(self): 
		return True if self.top == -1 else False
	
	def peek(self): 
		return self.array[-1] 
	
	def pop(self): 
		if not self.isEmpty(): 
			self.top -= 1
			return self.array.pop() 
		else: 
			return "$"
	
	def push(self, op): 
		self.top += 1
		self.array.append(op) 

	def isOperand(self, ch): 
		return ch.isalpha() 

	def notGreater(self, i): 
		try: 
			a = self.precedence[i] 
			b = self.precedence[self.peek()[0]] 
			return True if a <= b else False
		except KeyError: 
			return False
			

	def infixToPostfix(self, exp): 
		
		for i in exp: 
			# If the character is an operand, add it to output 
			if 'Constant' in i[0]: 
				self.output.append(i) 
			
			# If the character is an '(', push it to stack 
			elif 'parentheses_open' in i[0]: 
				self.push(i) 

			# If the scanned character is an ')', pop and output from the stack until and '(' is found 
			elif 'parentheses_close' in i[0]: 
				while( (not self.isEmpty()) and self.peek()[0] != 'parentheses_open'): 
					a = self.pop() 
					self.output.append(a) 
				if (not self.isEmpty() and self.peek()[0] != 'parentheses_open'): 
					return -1
				else: 
					self.pop() 

			# An operator is encountered 
			else: 
				while(not self.isEmpty() and self.notGreater(i[0])): 
					self.output.append(self.pop()) 
				self.push(i) 

		# pop all the operator from the stack 
		while not self.isEmpty(): 
			self.output.append(self.pop()) 

		return (self.output) 
