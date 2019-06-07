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
	#Pruebas generador
		#stage 1
		self.assertEqual (generator_test.assembler_no_space(ensambladorEsperado1(),ensambladorEsperado2()), 1,"Prueba assembler_no_space fallida")
		self.assertEqual (generator_test.assembler_return_2(ensambladorEsperado1(),ensambladorEsperado2()), 1 , "Prueba assembler_return_2 fallida")
		self.assertEqual (generator_test.assembler_return_0(ensambladorEsperado1(),ensambladorEsperado2()), 1, "Prueba assembler_return_0 fallida")
		self.assertEqual (generator_test.assembler_spaces(ensambladorEsperado1(), ensambladorEsperado2()), 1, "Prueba assembler_spaces fallida")
		self.assertEqual (generator_test.assembler_multi_digit(ensambladorEsperado1(), ensambladorEsperado2()), 1, "Prueba assembler_multi_digit fallida")
		self.assertEqual (generator_test.assembler_no_newlines(ensambladorEsperado1(), ensambladorEsperado2()), 1, "Prueba assembler_no_newlines fallida")
		self.assertEqual (generator_test.assembler_newlines(ensambladorEsperado1(), ensambladorEsperado2()), 1, "Prueba assembler_newlines fallida")
		
		#stage 2
		self.assertEqual (assembler_bitwise(), 1,"Prueba assembler_bitwise fallida")
		self.assertEqual (assembler_nested_ops(), 1,"Prueba assembler_nested_ops fallida")
		self.assertEqual (assembler_nested_ops_2(), 1,"Prueba assembler_nested_ops_2 fallida")
		self.assertEqual (assembler_not_zero(), 1,"Prueba assembler_not_zero fallida")
		self.assertEqual (assembler_not_five(), 1,"Prueba assembler_not_five fallida")
		self.assertEqual (assembler_bitwise_zero(), 1,"Prueba assembler_bitwise_zero fallida")
		self.assertEqual (assembler_neg(), 1,"Prueba assembler_neg fallida")
		print( "14 pruebas del generator ejecutadas correctamente")

	#Pruebas lexer
		#Stage 1
		self.assertEqual (lexer_test.lexer_no_space(lista()), 1, "Prueba lexer_no_space fallida")
		self.assertEqual (lexer_test.lexer_return_2(lista()), 1, "Prueba lexer_return_2 fallida")
		self.assertEqual (lexer_test.lexer_multi_digit(lista()), 1, "Prueba lexer_multi_digit fallida")
		self.assertEqual (lexer_test.lexer_spaces(lista()), 1, "Prueba lexer_spaces fallida")
		self.assertEqual (lexer_test.lexer_newlines(lista()), 1, "Prueba lexer_newlines fallida")
		self.assertEqual (lexer_test.lexer_no_newlines(lista()), 1, "Prueba lexer_no_newlines fallida")
		self.assertEqual (lexer_test.lexer_return_0(lista()), 1, "Prueba lexer_return_0 fallida")
		##Stage 2
		self.assertEqual (lexer_test.lexer_bitwise(lista()), 1, "Prueba lexer_bitwise fallida")
		self.assertEqual (lexer_test.lexer_bitwise_zero(lista()), 1, "Prueba lexer_bitwise_zero fallida")
		self.assertEqual (lexer_test.lexer_neg(lista()), 1, "Prueba lexer_neg fallida")
		self.assertEqual (lexer_test.lexer_nested_ops(lista()), 1, "Prueba lexer_nested_ops fallida")
		self.assertEqual (lexer_test.lexer_nested_ops_2(lista()), 1, "Prueba lexer_nested_ops_2 fallida")
		self.assertEqual (lexer_test.lexer_not_five(lista()), 1, "Prueba lexer_note_five fallida")
		self.assertEqual (lexer_test.lexer_not_zero(lista()), 1, "Prueba lexer_note_zero fallida")
		##Stage 3
		self.assertEqual (lexer_test.lexer_add(lista()), 1, "Prueba lexer_add fallida")
		self.assertEqual (lexer_test.lexer_associativity(lista()), 1, "Prueba lexer_associativity fallida")
		self.assertEqual (lexer_test.lexer_associativity_2(lista()), 1, "Prueba lexer_associativity_2 fallida")
		self.assertEqual (lexer_test.lexer_div(lista()), 1, "Prueba lexer_div fallida")
		self.assertEqual (lexer_test.lexer_mult(lista()), 1, "Prueba lexer_mult fallida")
		self.assertEqual (lexer_test.lexer_parens(lista()), 1, "Prueba lexer_parens fallida")
		self.assertEqual (lexer_test.lexer_precedence(lista()), 1, "Prueba lexer_precedence fallida")
		self.assertEqual (lexer_test.lexer_sub(lista()), 1, "Prueba lexer_sub fallida")
		self.assertEqual (lexer_test.lexer_sub_neg(lista()), 1, "Prueba lexer_sub_neg fallida")
		self.assertEqual (lexer_test.lexer_unop_add(lista()), 1, "Prueba lexer_unop_add fallida")
		self.assertEqual (lexer_test.lexer_unop_parens(lista()), 1, "Prueba lexer_unop_parens fallida")
		##
		print("25 pruebas del Lexer ejecutadas correctamente")

	#Pruebas parser
		##Stage 1
		self.assertEqual (parser_test.arbol_return_2(arbolEsperado()), 1, "Prueba parser_return_2 fallida")
		self.assertEqual (parser_test.arbol_multi_digit(arbolEsperado()), 1, "Prueba parser_multi_digit fallida")
		self.assertEqual (parser_test.arbol_newlines(arbolEsperado()), 1, "Prueba parser_newlines fallida")
		self.assertEqual (parser_test.arbol_no_newlines(arbolEsperado()), 1, "Prueba parser_no_newlines fallida")
		self.assertEqual (parser_test.arbol_return_0(arbolEsperado()), 1, "Prueba parser_return_0 fallida")
		##Stage 2
		self.assertEqual (parser_test.arbol_bitwise(arbolEsperado()), 1, "Prueba parser_bitwise fallida")
		self.assertEqual (parser_test.arbol_bitwise_zero(arbolEsperado()), 1, "Prueba parser_bitwise_zero fallida")
		self.assertEqual (parser_test.arbol_neg(arbolEsperado()), 1, "Prueba parser_neg fallida")
		self.assertEqual (parser_test.arbol_nested_ops(arbolEsperado()), 1, "Prueba parser_nested_ops fallida")
		self.assertEqual (parser_test.arbol_nested_ops_2(arbolEsperado()), 1, "Prueba parser_nested_ops_2 fallida")
		self.assertEqual (parser_test.arbol_not_five(arbolEsperado()), 1, "Prueba parser_not_five fallida")
		self.assertEqual (parser_test.arbol_not_zero(arbolEsperado()), 1, "Prueba parser_not_zero fallida")
		##Stage 3
		self.assertEqual (parser_test.arbol_add(arbolEsperado()), 1, "Prueba parser_add fallida")
		self.assertEqual (parser_test.arbol_associativity(arbolEsperado()), 1, "Prueba parser_associativity fallida")
		self.assertEqual (parser_test.arbol_associativity_2(arbolEsperado()), 1, "Prueba parser_associativity_2 fallida")
		self.assertEqual (parser_test.arbol_div(arbolEsperado()), 1, "Prueba parser_div fallida")
		self.assertEqual (parser_test.arbol_mult(arbolEsperado()), 1, "Prueba parser_mult fallida")
		self.assertEqual (parser_test.arbol_parens(arbolEsperado()), 1, "Prueba parser_parens fallida")
		self.assertEqual (parser_test.arbol_precedence(arbolEsperado()), 1, "Prueba parser_precedence fallida")
		self.assertEqual (parser_test.arbol_sub(arbolEsperado()), 1, "Prueba parser_sub fallida")
		self.assertEqual (parser_test.arbol_sub_neg(arbolEsperado()), 1, "Prueba parser_sub_neg fallida")
		self.assertEqual (parser_test.arbol_unop_add(arbolEsperado()), 1, "Prueba parser_unop_add fallida")
		self.assertEqual (parser_test.arbol_unop_parens(arbolEsperado()), 1, "Prueba parser_unop_parens fallida")
		print("23 pruebas del parser ejecutadas correctamente") 

	#pruebas invalidas

		##Stage 1
		self.assertEqual (invalid_test.arbol_no_brace(), 0, "Prueba arbol_no_brace fallida")
		self.assertEqual (invalid_test.arbol_missing_paren(), 0, "Prueba arbol_missing_paren fallida")
		self.assertEqual (invalid_test.arbol_no_semicolon(), 0, "Prueba arbol_no_semicolon fallida")
		self.assertEqual (invalid_test.lexer_missing_paren(lista1()), 0, "Prueba lexer_missing_paren fallida")
		self.assertEqual (invalid_test.lexer_missing_retval(lista1()), 0, "Prueba lexer_missing_retval fallida")
		#Stage 2
		self.assertEqual (invalid_test.lexer_no_brace(lista1()), 0, "Prueba lexer_no_brace fallida")
		self.assertEqual (invalid_test.lexer_no_semicolon(lista1()), 0, "Prueba lexer_no_semicolon fallida")
		self.assertEqual (invalid_test.arbol_missing_const(), 0, "Prueba arbol_missing_const fallida")
		self.assertEqual (invalid_test.arbol_missing_semicolon(), 0, "Prueba arbol_missing_semicolon fallida")
		self.assertEqual (invalid_test.arbol_nested_missing_const(), 0, "Prueba arbol_nested_missing_const fallida")
		#Stage 3
		self.assertEqual (invalid_test.arbol_wrong_order(), 0, "Prueba arbol_wrong_order fallida")
		self.assertEqual (lexer_stage2_missing_const(lista2()), 0, "Prueba lexer_stage2_missing_const fallida")
		self.assertEqual (lexer_wrong_order(lista2()), 0, "Prueba lexer_wrong_order fallida")
		self.assertEqual (lexer_stage2_missing_semicolon(lista2()), 0, "Prueba lexer_stage2_missing_semicolon fallida")
		self.assertEqual (lexer_nested_missing_const(lista2()), 0, "Prueba lexer_nested_missing_const fallida")



		print("15 pruebas invalidas ejecutadas correctamente") 
		print("Total de pruebas ejecutadas: 77")

if __name__ == '__main__':
	unittest.main()
pruebasValidas()