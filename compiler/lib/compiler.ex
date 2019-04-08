defmodule Xforce do

	def  main do
			file_path="ejemplos/ejemplo.c"
			assembly_path = String.replace_trailing(file_path, ".c", ".s")
			lista_toks=Lexer.main(file_path)
			arbol_ats=Parser.parse_function(lista_toks)
			assembler=CodeGenerator.generate_code(arbol_ats)
	    oo=Linker.generate_binary(assembler, assembly_path)
			IO.inspect(oo)
	end
end
