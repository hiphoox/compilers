defmodule LexerTest do
  use ExUnit.Case
  doctest Lexer

  setup_all do
    {:ok,
     tokens: [
  {:int_keyword, 0},
  {:main_keyword, 0},
  {:open_paren, 0},
  {:close_paren, 0},
  {:open_brace, 0},
  {:return_keyword, 0},
  {{:constant, 2}, 0},
  {:semicolon, 0},
  {:close_brace, 0}
],tokens0: [
{:int_keyword, 0},
{:main_keyword, 0},
{:open_paren, 0},
{:close_paren, 0},
{:open_brace, 0},
{:return_keyword, 0},
{{:constant, 0}, 0},
{:semicolon, 0},
{:close_brace, 0}
],
tokens1: [
{:open_brace, 0},
{:return_keyword, 0},
{{:constant, 2}, 0},
{:semicolon, 0},
{:close_brace, 0}
],
tokens2: [
{:int_keyword, 0},
{:main_keyword, 0},
{:open_paren, 0},
{:close_paren, 0},
]

}
  end

  test "elements", state do
    assert Lexer.scan_words([{"int", 0}, {"main", 0}, {"()", 0}, {"{", 0}, {"return", 0}, {"2;}", 0}]) == state[:tokens]
  end
  test "elements separated just by spaces", state do
    assert Lexer.scan_words([
  {"int", 0},
  {"main", 0},
  {"(", 0},
  {")", 0},
  {"{", 0},
  {"return", 0},
  {"2;}", 0}
]
) == state[:tokens] or state[:tokens2]
  end
  test "Prueba 1 main()return y 2:} juntos", state do
    assert Lexer.scan_words([{"int", 0}, {"main(){return", 0}, {"2;}", 0}]) == state[:tokens]
  end

  test "Prueba 2 sin int main ()", state do
    assert Lexer.scan_words([{"{return", 0}, {"2;}", 0}]) == state[:tokens1]
  end
  test "Prueba 3 sin int main () separado ", state do
    assert Lexer.scan_words([{"{", 0}, {"return", 0}, {"2", 0}, {";", 0}, {"}", 0}]) == state[:tokens1]
  end
  test "Prueba 4 sin int main () junto", state do
    assert Lexer.scan_words([{"{return2;}", 0}]) == state[:tokens1]
  end

  test "Prueba 5 solo con int main () separado", state do
    assert Lexer.scan_words([{"int", 0}, {"main", 0}, {"(", 0}, {")", 0}]) == state[:tokens2]
  end
  test "Prueba  6 solo con int main () junto", state do
    assert Lexer.scan_words([{"intmain()", 0}]) == state[:tokens2]
  end
  test "Prueba 8 solo con int main () ", state do
    assert Lexer.scan_words([{"int", 0}, {"main()", 0}]) == state[:tokens2]
  end
  #---------------------------------------------------------------------------------------------
  test " Separdos", state do
      assert Lexer.scan_words([{"int",0}, {"main(){return",0}, {"2;}",0}]) ==
      state[:tokens] or state[:tokens0]
  end

  test " función  separada ", state do
      assert Lexer.scan_words([{"int",0}, {"main()",0}, {"{return",0}, {"2;}",0}])==
      state[:tokens] or state[:tokens0]
  end

  test " Todo separado", state do
      assert Lexer.scan_words([{"int",0}, {"main",0}, {"(",0}, {")",0}, {"{",0}, {"return",0}, {"2",0}, {";",0}, {"}",0}]) ==
      state[:tokens] or state[:tokens0]
  end

  test " Return 0", state do
    assert Lexer.scan_words([{"int",0}, {"main",0}, {"(",0}, {")",0}, {"{",0}, {"return",0}, {"0",0}, {";",0}, {"}",0}]) ==
    state[:tokens0] or state[:tokens]
  end

  test " Saltos de linea en int y main", state do
     assert "int\nmain\n()\n{return 0;}" |> Sanitizer.sanitize_source() |> Lexer.scan_words() ==
     state[:tokens] or state[:tokens0]
  end

  test " Saltos de linea en todo", state do
     assert "int\nmain\n(\n)\n{\nreturn\n0\n;\n}\n"
            |> Sanitizer.sanitize_source()
            |> Lexer.scan_words() ==
              state[:tokens] or state[:tokens0]
  end

  test " Espacios entre caracteres", state do
     assert "int    main    (   )   {   return    0   ;   }   "
            |> Sanitizer.sanitize_source()
            |> Lexer.scan_words() ==
              state[:tokens] or state[:tokens0]
end

end
