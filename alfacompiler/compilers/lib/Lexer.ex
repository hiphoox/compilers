defmodule Lexer do

  def scan_words(words) do
    try do
    Enum.flat_map(words, &lex_raw_tokens/1) #Se itera la lista
    rescue
    e in RuntimeError  -> IO.puts("Error: " <> e.message <> "Sintaxis invalida")
    end
  end

def get_constant(program) do
  #se leen enteros
  try do
    case Regex.run(~r/^\d+/, program) do
      [value] ->
        {{:constant, String.to_integer(value)}, String.trim_leading(program, value)}
    end
  rescue
    CaseClauseError -> nil
  end
  end
def lex_raw_tokens(program) when program != "" do
  try do
    {token, rest} =
      case program do
        "{" <> rest ->
          {:a_llave, rest}

        "}" <> rest ->
          {:c_llave, rest}

        "(" <> rest ->
          {:a_parentesis, rest}

        ")" <> rest ->
          {:c_parentesis, rest}

        ";" <> rest ->
          {:semicolon, rest}

        "return" <> rest ->
          {:return_keyword, rest}

        "int" <> rest ->
          {:int_keyword, rest}

        "main" <> rest ->
          {:main_keyword, rest}

        rest ->
          get_constant(rest)
      end

    remaining_tokens = lex_raw_tokens(rest)
    [token | remaining_tokens]

    rescue
      MatchError -> IO.inspect(program, label: "Sintaxis invalida")
    end
  end

  def lex_raw_tokens(_program) do
    []
  end
end
