defmodule Lexer do
  def scan_words(words) do
    Enum.flat_map(words, &lex_raw_tokens/1)
  end

  def get_constant(program,linea) do
		valor=Regex.run(~r/^\d+/, program)
		if valor != :nil do
					case valor do
						[value] ->
						{{{:constant, String.to_integer(value)},linea}, String.trim_leading(program, value)}

					end
		else
			[program,"ERROR"]
		end
	end



  def lex_raw_tokens({program,linea}) when program != "" do
     IO.inspect(program)
    linea_keyword=linea
    {token, rest} =
      case program do
        "{" <> rest ->
          {{:open_brace,linea_keyword}, rest}

        "}" <> rest ->
          {{:close_brace,linea_keyword}, rest}

        "(" <> rest ->
          {{:open_paren,linea_keyword}, rest}

        ")" <> rest ->
          {{:close_paren,linea_keyword}, rest}

        ";" <> rest ->
          {{:semicolon, linea_keyword}, rest}

        "return" <> rest ->
          {{:return_keyword, linea_keyword}, rest}

        "int" <> rest ->
          {{:int_keyword, linea_keyword}, rest}

        "main" <> rest ->
          {{:main_keyword, linea_keyword}, rest}

        rest ->
          get_constant(rest,linea)
      end
	if rest != "" do
		auxiliar_token={rest,linea}
		remaining_tokens=lex_raw_tokens(auxiliar_token)
		toke=[token | remaining_tokens]
	else 
		remaining_tokens=lex_raw_tokens(rest)
		toke=[token | remaining_tokens]
	end
   
  end

  def lex_raw_tokens(_program) do
    []
  end
end
