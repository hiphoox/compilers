#para controlar las pruebas

from lexer_test import *
from generator_test import *
from invalid_test import *
from parser_test import *

def pruebasValidas():
	
	assert assembler_no_space(ensambladorEsperado1(),ensambladorEsperado2())== 1, "Prueba assembler_no_space fallida"
	assert assembler_return_2(ensambladorEsperado1(),ensambladorEsperado2())== 1, "Prueba assembler_return_2 fallida"
	assert assembler_return_0(ensambladorEsperado1(),ensambladorEsperado2())== 1, "Prueba assembler_return_0 fallida"
	assert assembler_spaces(ensambladorEsperado1(), ensambladorEsperado2()) == 1, "Prueba assembler_spaces fallida"
	assert assembler_multi_digit(ensambladorEsperado1(), ensambladorEsperado2()) == 1, "Prueba assembler_multi_digit fallida"
	assert assembler_no_newlines(ensambladorEsperado1(), ensambladorEsperado2()) == 1, "Prueba assembler_no_newlines fallida"
	assert assembler_newlines(ensambladorEsperado1(), ensambladorEsperado2()) == 1, "Prueba assembler_newlines fallida"
	print("7 pruebas del generator ejecutadas correctamente")

	assert lexer_no_space(lista()) == 1, "Prueba lexer_no_space fallida"
	assert lexer_return_2(lista()) == 1, "Prueba lexer_return_2 fallida"
	assert lexer_multi_digit(lista()) == 1, "Prueba lexer_multi_digit fallida"
	assert lexer_spaces(lista()) == 1, "Prueba lexer_spaces fallida"
	assert lexer_newlines(lista()) == 1, "Prueba lexer_newlines fallida"
	assert lexer_no_newlines(lista()) == 1, "Prueba lexer_no_newlines fallida"
	assert lexer_return_0(lista()) == 1, "Prueba lexer_return_0 fallida"
	print("7 pruebas del Lexer ejecutadas correctamente")

	assert arbol_return_2(arbolEsperado()) == 1, "Prueba parser_return_2 fallida"
	assert arbol_multi_digit(arbolEsperado()) == 1, "Prueba parser_multi_digit fallida"
	assert arbol_newlines(arbolEsperado()) == 1, "Prueba parser_newlines fallida"
	assert arbol_no_newlines(arbolEsperado()) == 1, "Prueba parser_no_newlines fallida"
	assert arbol_return_0(arbolEsperado()) == 1, "Prueba parser_return_0 fallida"
	print("6 pruebas del parser ejecutadas correctamente") 

	#pruebas invalidas

	assert arbol_no_brace() == 0, "Prueba arbol_no_brace fallida"
	assert arbol_missing_paren() == 0, "Prueba arbol_missing_paren fallida"
	assert arbol_wrong_case() == 0, "Prueba arbol_wrong_case fallida"
	assert arbol_missing_retval() == 0, "Prueba arbol_missing_retval fallida"
	assert arbol_no_semicolon()== 0, "Prueba arbol_no_semicolon fallida"

	print("5 pruebas invalidas ejecutadas correctamente") 

pruebasValidas()