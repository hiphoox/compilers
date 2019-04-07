defmodule Lexer do

    def scan_words(words) do
      Enum.flat_map(words, &lex_raw_tokens/1)
    end

    def get_constant(program) do
      case Regex.run(~r/\d+/, program) do
        [value] -> {{:constant, String.to_integer(value)}, String.trim_leading(program,value)}
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

        ")" <> rest -> {:close_parenthesis, rest}

        ";" <> rest -> {:semicolon, rest}

        rest -> get_constant(rest)
      end
      remaining_tokens = lex_raw_tokens(rest)
      [token | remaining_tokens]
    end

    def lex_raw_tokens(program) do
      []
    end

end
