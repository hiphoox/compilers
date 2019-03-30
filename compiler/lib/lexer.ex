defmodule Lexer do

	def  main(file) do
	file_content=File.read!(file)
	trimmed_content= String.trim(file_content)
	words =Regex.split(~r/\r\n/,trimmed_content)
	contador=0
	regresa_lexer=hacer_lista(words,contador)
	IO.inspect(regresa_lexer)
	end
  def hacer_lista(program,linea) when program != []  do
		    codigo_linea=hd program
		    otras_lineas=tl program
				lista_token_sin_num = Regex.split(~r/\s+/,codigo_linea, trim: true)
				lista_token_etiquetados=lex_law_tokens(lista_token_sin_num,linea)
				lista_token_con_num=Enum.flat_map(lista_token_etiquetados, fn x -> [{x,linea}] end)
		    linea=linea+1
		    otrostokens=hacer_lista(otras_lineas,linea)
		    lista_token_con_num ++ otrostokens
  end

	def get_constan(program,linea) do
		valor=Regex.run(~r/^\d+/, program)
		if valor != :nil do
					case valor do
						[value] ->
						 [{:constant,String.to_integer(value)},String.trim_leading(program, value)]
					end
		else
			IO.puts("ERROR LEXICO; EN linea")
			IO.inspect(linea)
			IO.puts("NO  espera:")
			IO.inspect(program)
			[program,"ERROR"]
		end
	end



	def lex_law_tokens(program,linea) when program != [] do
						token_actual=hd program
						otros_tokens=tl program
						[token, rest]=
						case token_actual do
						"{" <> rest ->
							[:open_brace, rest]
						"}" <> rest ->
							[:close_brace, rest]
						"(" <> rest ->
							[:open_paren, rest]
						")" <> rest ->
							[:close_paren, rest]
						";" <> rest ->
							[:semicolon, rest]
						"return" <> rest ->
							[:return__keyword, rest]
						"int" <> rest ->
							[:int_keyword, rest]
						"main" <> rest ->
							[:main_keyword, rest]
						"ERROR" <>	rest ->
							[:ERROR, rest]
						rest-> get_constan(token_actual,linea)

						end
						if rest != "" and rest != nil do
							auxiliar=[rest]++otros_tokens
							remaining_tokens=lex_law_tokens(auxiliar,linea)
							toke=[token | remaining_tokens]
						else
							remaining_tokens=lex_law_tokens(otros_tokens,linea)
							toke=[token | remaining_tokens]
						end
	end
	def lex_law_tokens(program,linea) do
	[]
end
	def hacer_lista(program,contador) do
		[]
	end
end
