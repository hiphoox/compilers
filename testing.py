#para controlar las pruebas

from lexer_test import *
from generator_test import *

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

pruebasValidas()