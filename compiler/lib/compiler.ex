defmodule Xforce do

	def  main do
			nom_file="test/example_S_1.c"
			lista_toks=Lexer.main(nom_file)
			arbol_ats=Parser.parse_function(lista_toks)
	end

end
