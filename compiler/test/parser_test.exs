defmodule ParserTest do
  use ExUnit.Case
  doctest Parser

  setup_all do
    {:ok,
    arbol: Parser.parse_program([
  {:int_keyword, 0},
  {:main_keyword, 0},
  {:open_paren, 0},
  {:close_paren, 0},
  {:open_brace, 0},
  {:return_keyword, 0},
  {{:constant, 2}, 0},
  {:semicolon, 0},
  {:close_brace, 0}
]),
arbol0: Parser.parse_program([
{:int_keyword, 0},
{:main_keyword, 0},
{:open_paren, 0},
{:close_paren, 0},
{:open_brace, 0},
{:return_keyword, 0},
{{:constant, 2}, 0},
{:semicolon, 0},
{:close_brace, 0}
]),
error1: {:error, "Error, close brace missed in line", 0, :return_keyword},

}
  end
  test "token justos", state do
    assert Parser.parse_program([
  {:int_keyword, 0},
  {:main_keyword, 0},
  {:open_paren, 0},
  {:close_paren, 0},
  {:open_brace, 0},
  {:return_keyword, 0},
  {{:constant, 2}, 0},
  {:semicolon, 0},
  {:close_brace, 0}
]) == state[:arbol]
  end

  test "mas de un main token", state do
    assert Parser.parse_program([
      {:int_keyword, 0},
      {:main_keyword, 0},
      {:open_paren, 0},
      {:close_paren, 0},
      {:open_brace, 0},
      {:main_keyword, 0},
      {:return_keyword, 0},
      {{:constant, 2}, 0},
      {:semicolon, 0},
      {:close_brace, 0}
    ]) == state[:error1]
  end

#---------------------------------------------------------------------------------
test " Separdos", state do
    assert Lexer.scan_words([{"int",0}, {"main(){return",0}, {"2;}",0}])|> Parser.parse_program() ==
    state[:arbol] or state[:arbol0]
end

test " función  separada ", state do
    assert Lexer.scan_words([{"int",0}, {"main()",0}, {"{return",0}, {"2;}",0}])|> Parser.parse_program() ==
    state[:arbol] or state[:arbol0]
end

test " Todo separado", state do
    assert Lexer.scan_words([{"int",0}, {"main",0}, {"(",0}, {")",0}, {"{",0}, {"return",0}, {"2",0}, {";",0}, {"}",0}])|> Parser.parse_program() ==
    state[:arbol] or state[:arbol0]
end

test " Return 0", state do
  assert Lexer.scan_words([{"int",0}, {"main",0}, {"(",0}, {")",0}, {"{",0}, {"return",0}, {"0",0}, {";",0}, {"}",0}]) |> Parser.parse_program() ==
  state[:arbol] or state[:arbol0]
end

test " Saltos de linea en int y main", state do
   assert "int\nmain\n()\n{return 0;}" |> Sanitizer.sanitize_source() |> Lexer.scan_words()|> Parser.parse_program() ==
   state[:arbol] or state[:arbol0]
end

test " Saltos de linea en todo", state do
   assert "int\nmain\n(\n)\n{\nreturn\n0\n;\n}\n"
          |> Sanitizer.sanitize_source()
          |> Lexer.scan_words()
          |> Parser.parse_program() ==
          state[:arbol] or state[:arbol0]
end

test " Espacios entre caracteres", state do
   assert "int    main    (   )   {   return    0   ;   }   "
          |> Sanitizer.sanitize_source()
          |> Lexer.scan_words()
          |> Parser.parse_program() ==
          state[:arbol] or state[:arbol0]
end

end
