defmodule Xforce do

	def  main do
			nom_file="test/example_S_1.c"
			lista_toks=Lexer.main(nom_file)
			arbol_ast=Parser.parse_function(lista_toks)
			generatedCode=CodeGenerator.generate_code(arbol_ast);
	end

end
