defmodule Lexer do
  def scan_words(words) do
    Enum.flat_map(words, &lex_raw_tokens/1)
  end

  def get_constant(program) do
    #se leen enteros
    auxiliar = Regex.run(~r/^\d+/, program)
    if auxiliar != nil do
      case auxiliar do
        [value] ->
          {{:constant, String.to_integer(value)}, String.trim_leading(program, value)}
      end
    else
      {["error", program], ""}
    end
  end

  def lex_raw_tokens(program) when program != "" do

    {token, rest} =
      case program do
        "int" <> rest ->
          {:int_keyword, rest}

        "return" <> rest ->
          {:return_keyword, rest}

        "main" <> rest ->
          {:main_keyword, rest}

        "{" <> rest ->
          {:a_llave, rest}

        "}" <> rest ->
          {:c_llave, rest}

        "(" <> rest ->
          {:a_parentesis, rest}

        ")" <> rest ->
          {:c_parentesis, rest}

        "-" <> rest ->
          {:negacion, rest}


          " + "  <> rest ->
            { : add , rest}

          " * "  <> rest ->
            { : mult , rest}

          " / "  <> rest ->
            { : div , rest}


        "~" <> rest ->
          {:complemento, rest}

        "!" <> rest ->
          {:logical_negation, rest}

        ";" <> rest ->
          {:semicolon, rest}

        rest -> get_constant(rest)
      end

    if rest != "" do
      auxiliar2 = rest
      resto = lex_raw_tokens(auxiliar2)
      [token | resto]
    else
      resto = lex_raw_tokens(rest)
      [token | resto]
    end
  end

  def lex_raw_tokens(_program) do
    []
  end
end
