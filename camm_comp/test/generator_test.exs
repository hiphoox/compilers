defmodule GeneratorTest do
  use ExUnit.Case
  doctest Generator

  setup_all do
    {:ok,
    assembler: Generator.generate_code(Parser.parse_program([
      :intkeyword,
      :mainkeyword,
      :open_parenthesis,
      :close_parenthesis,
      :open_brace,
      :returnkeyword,
      {:constant, 2},
      :semicolon,
      :close_brace])),

    assembler0: Generator.generate_code(Parser.parse_program([
      :intkeyword,
      :mainkeyword,
      :open_parenthesis,
      :close_parenthesis,
      :open_brace,
      :returnkeyword,
      {:constant, 0},
      :semicolon,
      :close_brace])),

    assembler1: Generator.generate_code(Parser.parse_program([
      :intkeyword,
      :mainkeyword,
      :open_parenthesis,
      :close_parenthesis,
      :open_brace,
      :returnkeyword,
      :operator_negation,
      {:constant, 2},
      :semicolon,
      :close_brace])),

    assembler2: Generator.generate_code(Parser.parse_program([
      :intkeyword,
      :mainkeyword,
      :open_parenthesis,
      :close_parenthesis,
      :open_brace,
      :returnkeyword,
      :operator_logical_negation,
      {:constant, 2},
      :semicolon,
      :close_brace])),

    assembler3: Generator.generate_code(Parser.parse_program([
      :intkeyword,
      :mainkeyword,
      :open_parenthesis,
      :close_parenthesis,
      :open_brace,
      :returnkeyword,
      :operator_bitwise_complement,
      {:constant, 2},
      :semicolon,
      :close_brace]))
}
  end

       test " :Separdos por espacios", state do
           assert Lexer.scan_words(["int", "main(){return", "2;}"])
           |> Parser.parse_program()
           |>Generator.generate_code() == state[:assembler] or state[:assembler0]
       end

       test " :La función esta separada del cuerpo", state do
           assert Lexer.scan_words(["int", "main()", "{return", "2;}"])
           |> Parser.parse_program()
           |>Generator.generate_code() == state[:assembler] or state[:assembler0]
       end

       test " :Todo esta separado", state do
           assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "2", ";", "}"])
           |> Parser.parse_program()
           |>Generator.generate_code() == state[:assembler] or state[:assembler0]
       end

       test " :Regresando un 0", state do
           assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "0", ";", "}"])
           |> Parser.parse_program()
           |>Generator.generate_code() == state[:assembler] or state[:assembler0]
       end

       test " :Usando saltos de linea en int y main", state do
           assert "int\nmain\n()\n{return 0;}" |> Sanitizer.sanitize_source() |> Lexer.scan_words()
           |> Parser.parse_program()
           |>Generator.generate_code() == state[:assembler] or state[:assembler0]
       end

       test " :Usando saltos de linea en todo usando sanitizer", state do
          assert "int\nmain\n(\n)\n{\nreturn\n0\n;\n}\n"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parse_program()
           |>Generator.generate_code() == state[:assembler] or state[:assembler0]
       end

       test " :Con espacios entre los caracteres en todo usando sanitizer", state do
          assert "int    main    (   )   {   return    0   ;   }   "
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words()
           |> Parser.parse_program()
           |>Generator.generate_code() == state[:assembler] or state[:assembler0]
       end

       # Más pruebas

       test " :Una sola cadena", state do
           assert Lexer.scan_words(["intmain(){return0;}"])
           |> Parser.parse_program()
           |>Generator.generate_code() == state[:assembler] or state[:assembler0]
       end

       test " :Elementos separados por espacios", state do
           assert Lexer.scan_words(["int", "main(){return", "0;}"])
           |> Parser.parse_program()
           |>Generator.generate_code() == state[:assembler] or state[:assembler0]
       end

       test " :Separados en dos cadenas", state do
         assert Lexer.scan_words(["intmain()","{return0;}"])
           |> Parser.parse_program()
           |>Generator.generate_code() == state[:assembler] or state[:assembler0]
       end

       test " :Probando negación", state do
           assert Lexer.scan_words(["intmain(){return-2;}"])
           |> Parser.parse_program()
           |>Generator.generate_code() == state[:assembler1]
       end

       test " :Probando negación lógica", state do
           assert Lexer.scan_words(["int", "main(){return", "!2;}"])
           |> Parser.parse_program()
           |>Generator.generate_code() == state[:assembler2]
       end

       test " :Probando complemento", state do
         assert Lexer.scan_words(["intmain()","{return~2;}"])
           |> Parser.parse_program()
           |>Generator.generate_code() == state[:assembler3]
       end

end
