#para controlar las pruebas
import unittest 
from lexer_test import * 
from generator_test import *
from invalid_test import *
from parser_test import *
import generator_test 
import lexer_test
import parser_test
import invalid_test

class test_compiler(unittest.TestCase):

	def testValidas(self):
		self.assertEqual (generator_test.assembler_no_space(ensambladorEsperado1(),ensambladorEsperado2()), 1,"Prueba assembler_no_space fallida")
		self.assertEqual (generator_test.assembler_return_2(ensambladorEsperado1(),ensambladorEsperado2()), 1 , "Prueba assembler_return_2 fallida")
		self.assertEqual (generator_test.assembler_return_0(ensambladorEsperado1(),ensambladorEsperado2()), 1, "Prueba assembler_return_0 fallida")
		self.assertEqual (generator_test.assembler_spaces(ensambladorEsperado1(), ensambladorEsperado2()), 1, "Prueba assembler_spaces fallida")
		self.assertEqual (generator_test.assembler_multi_digit(ensambladorEsperado1(), ensambladorEsperado2()), 1, "Prueba assembler_multi_digit fallida")
		self.assertEqual (generator_test.assembler_no_newlines(ensambladorEsperado1(), ensambladorEsperado2()), 1, "Prueba assembler_no_newlines fallida")
		self.assertEqual (generator_test.assembler_newlines(ensambladorEsperado1(), ensambladorEsperado2()), 1, "Prueba assembler_newlines fallida")
		
		print( "7 pruebas del generator ejecutadas correctamente")

		self.assertEqual (lexer_test.lexer_no_space(lista()), 1, "Prueba lexer_no_space fallida")
		self.assertEqual (lexer_test.lexer_return_2(lista()), 1, "Prueba lexer_return_2 fallida")
		self.assertEqual (lexer_test.lexer_multi_digit(lista()), 1, "Prueba lexer_multi_digit fallida")
		self.assertEqual (lexer_test.lexer_spaces(lista()), 1, "Prueba lexer_spaces fallida")
		self.assertEqual (lexer_test.lexer_newlines(lista()), 1, "Prueba lexer_newlines fallida")
		self.assertEqual (lexer_test.lexer_no_newlines(lista()), 1, "Prueba lexer_no_newlines fallida")
		self.assertEqual (lexer_test.lexer_return_0(lista()), 1, "Prueba lexer_return_0 fallida")
		print("7 pruebas del Lexer ejecutadas correctamente")


		self.assertEqual (parser_test.arbol_return_2(arbolEsperado()), 1, "Prueba parser_return_2 fallida")
		self.assertEqual (parser_test.arbol_multi_digit(arbolEsperado()), 1, "Prueba parser_multi_digit fallida")
		self.assertEqual (parser_test.arbol_newlines(arbolEsperado()), 1, "Prueba parser_newlines fallida")
		self.assertEqual (parser_test.arbol_no_newlines(arbolEsperado()), 1, "Prueba parser_no_newlines fallida")
		self.assertEqual (parser_test.arbol_return_0(arbolEsperado()), 1, "Prueba parser_return_0 fallida")

		print("5 pruebas del parser ejecutadas correctamente") 

	#pruebas invalidas

		self.assertEqual (invalid_test.arbol_no_brace(), 0, "Prueba arbol_no_brace fallida")
		self.assertEqual (invalid_test.arbol_missing_paren(), 0, "Prueba arbol_missing_paren fallida")
		self.assertEqual (invalid_test.arbol_missing_retval(), 0, "Prueba arbol_missing_retval fallida")
		self.assertEqual (invalid_test.arbol_no_semicolon(), 0, "Prueba arbol_no_semicolon fallida")
		self.assertEqual (invalid_test.lexer_missing_paren(lista()), 0, "Prueba lexer_missing_paren fallida")
		self.assertEqual (invalid_test.lexer_missing_retval(lista()), 0, "Prueba lexer_missing_retval fallida")
		self.assertEqual (invalid_test.lexer_no_brace(lista()), 0, "Prueba lexer_no_brace fallida")
		self.assertEqual (invalid_test.lexer_no_semicolon(lista()), 0, "Prueba lexer_no_semicolon fallida")

		print("8 pruebas invalidas ejecutadas correctamente") 

if __name__ == '__main__':
	unittest.main()
pruebasValidas()