defmodule Lexer do
  def scan_words(words) do
    Enum.flat_map(words, &lex_raw_tokens/1)
  end

  def get_constant(program) do
    valor = Regex.run(~r/^\d+/, program)

    if valor != nil do
      case valor do
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
        "int" <> rest -> {:intkeyword, rest}
        "return" <> rest -> {:returnkeyword, rest}
        "main" <> rest -> {:mainkeyword, rest}
        "{" <> rest -> {:open_brace, rest}
        "}" <> rest -> {:close_brace, rest}
        "(" <> rest -> {:open_parenthesis, rest}
        "-" <> rest -> {:operator_negation, rest}
        "+" <> rest -> {:operator_addition, rest}
        "*" <> rest -> {:operator_multiplication, rest}
        "/" <> rest -> {:operator_division, rest}
        "~" <> rest -> {:operator_bitwise_complement, rest}
        "!" <> rest -> {:operator_logical_negation, rest}
        ")" <> rest -> {:close_parenthesis, rest}
        ";" <> rest -> {:semicolon, rest}
        rest -> get_constant(rest)
      end

    if rest != "" do
      token_aux = rest
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
