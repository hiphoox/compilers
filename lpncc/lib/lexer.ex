
defmodule Lexer do
  def scan_words(words) do
    Enum.flat_map(words, &lex_raw_tokens/1)
  end

  def get_constant(program,linea) do
    val = Regex.run(~r/^\d+/, program)
    if val != nil do
      case val do
        [value] ->
          {{:constant, String.to_integer(value),linea}, String.trim_leading(program, value)}
      end
    else
      {["Error",program,linea],""}
    end
  end

  def lex_raw_tokens({program,linea}) when program != "" do
    kwLine = linea
    {token, rest} =
      case program do
        "{" <> rest ->
          {{:open_brace,kwLine}, rest}

        "}" <> rest ->
          {{:close_brace,kwLine}, rest}

        "(" <> rest ->
          {{:open_paren,kwLine}, rest}

        ")" <> rest ->
          {{:close_paren,kwLine}, rest}

        ";" <> rest ->
          {{:semicolon, kwLine}, rest}

        "return" <> rest ->
          {{:return_keyword, kwLine}, rest}

        "int" <> rest ->
          {{:int_keyword, kwLine}, rest}

        "main" <> rest ->
          {{:main_keyword, kwLine}, rest}
        "-" <> rest ->
          {{:substractor, kwLine}, rest}
        "~" <> rest ->
          {{:complemento, kwLine}, rest}
        "!" <> rest ->
          {{:negacion_logica, kwLine}, rest}

        rest ->
          get_constant(rest,linea)
      end

    if rest != "" do
      token_aux = {rest, linea}
      tokens_rest = lex_raw_tokens(token_aux)
      [token | tokens_rest]
    else
      tokens_rest = lex_raw_tokens(rest)
      [token | tokens_rest]
    end
  end

  def lex_raw_tokens(_program) do
    []
  end
end