
defmodule Lexer do
  def scan_words(words) do
    Enum.flat_map(words, &lex_raw_tokens/1)
  end

  def get_constant(program) do
    case Regex.run(~r/^\d+/, program) do
      [value] ->
        {{:constant, String.to_integer(value)}, String.trim_leading(program, value)}
    end
  end

  def lex_raw_tokens(program) when program != "" do
    {token, rest} =
      case program do
        "{" <> rest ->
          {:open_brace, rest}

        "}" <> rest ->
          {:close_brace, rest}

        "(" <> rest ->
          {:open_paren, rest}

        ")" <> rest ->
          {:close_paren, rest}

        ";" <> rest ->
          {:puntoycoma, rest}

        "-" <> rest -> 
          {:substractor, rest}

        "~" <> rest -> 
          {:complemento, rest}

        "!" <> rest -> 
          {:negacion_logica, rest}

        "return" <> rest ->
          {:return_keyword, rest}

        "int" <> rest ->
          {:int_keyword, rest}

        "main" <> rest ->
          {:main_keyword, rest}

        rest ->
          get_constant(rest)
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