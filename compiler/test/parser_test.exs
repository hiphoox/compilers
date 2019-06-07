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
error1: {:error, "Error: 8", 0, :complement_keyword},
error2: {:error, "Error: 8", 0, :main_keyword},
arbol_unitary: Parser.parse_program([
  {:int_keyword, 0},
  {:main_keyword, 0},
  {:open_paren, 0},
  {:close_paren, 0},
  {:open_brace, 0},
  {:return_keyword, 0},
  {:complement_keyword, 0},
  {:negative_logical, 0},
  {{:constant, 4}, 0},
  {:semicolon, 0},
  {:close_brace, 0}
]),
arbol_unitary1: Parser.parse_program([
  {:int_keyword, 0},
  {:main_keyword, 0},
  {:open_paren, 0},
  {:close_paren, 0},
  {:open_brace, 0},
  {:return_keyword, 0},
  {:negative_logical, 0},
  {{:constant, 2}, 0},
  {:semicolon, 0},
  {:close_brace, 0}
]),
arbol_unitary2: Parser.parse_program([
  {:int_keyword, 0},
  {:main_keyword, 0},
  {:open_paren, 0},
  {:close_paren, 0},
  {:open_brace, 0},
  {:return_keyword, 0},
  {:negative_keyword, 0},
  {:complement_keyword, 0},
  {:negative_logical, 0},
  {:negative_keyword, 0},
  {{:constant, 2}, 0},
  {:semicolon, 0},
  {:close_brace, 0}
]),
arbol_unitary3: Parser.parse_program([
  {:int_keyword, 0},
  {:main_keyword, 0},
  {:negative_keyword, 0},
  {:complement_keyword, 0},
  {:negative_logical, 0},
  {:negative_keyword, 0},
  {{:constant, 2}, 0},
  {:semicolon, 0},
  {:close_brace, 0}
]),
arbol_binario1: Parser.parse_program([
  {:int_keyword, 0},
  {:main_keyword, 0},
  {:open_paren, 0},
  {:close_paren, 0},
  {:open_brace, 0},
  {:return_keyword, 0},
  {:open_paren, 0},
  {{:constant, 5}, 0},
  {:negative_keyword, 0},
  {{:constant, 4}, 0},
  {:negative_keyword, 0},
  {{:constant, 7}, 0},
  {:negative_keyword, 0},
  {{:constant, 7}, 0},
  {:close_paren, 0},
  {:negative_keyword, 0},
  {{:constant, 10}, 0},
  {:semicolon, 0},
  {:close_brace, 0}
]),
arbol_binario2: Parser.parse_program([
  {:int_keyword, 0},
  {:main_keyword, 0},
  {:open_paren, 0},
  {:close_paren, 0},
  {:open_brace, 0},
  {:return_keyword, 0},
  {:negative_logical, 0},
  {:negative_keyword, 0},
  {:complement_keyword, 0},
  {:open_paren, 0},
  {{:constant, 5}, 0},
  {:negative_keyword, 0},
  {{:constant, 4}, 0},
  {:negative_keyword, 0},
  {{:constant, 7}, 0},
  {:negative_keyword, 0},
  {{:constant, 7}, 0},
  {:close_paren, 0},
  {:semicolon, 0},
  {:close_brace, 0}
]),
arbol_binario3: Parser.parse_program([
  {:int_keyword, 0},
  {:main_keyword, 0},
  {:open_paren, 0},
  {:close_paren, 0},
  {:open_brace, 0},
  {:return_keyword, 0},
  {{:constant, 5}, 0},
  {:negative_keyword, 0},
  {{:constant, 4}, 0},
  {:negative_keyword, 0},
  {{:constant, 7}, 0},
  {:negative_keyword, 0},
  {{:constant, 7}, 0},
  {:semicolon, 0},
  {:close_brace, 0}
]),
arbol_binario4: Parser.parse_program([
  {:int_keyword, 0},
  {:main_keyword, 0},
  {:open_paren, 0},
  {:close_paren, 0},
  {:open_brace, 0},
  {:return_keyword, 0},
  {:open_paren, 0},
  {{:constant, 5}, 0},
  {:negative_keyword, 0},
  {{:constant, 4}, 0},
  {:close_paren, 0},
  {:negative_keyword, 0},
  {:open_paren, 0},
  {{:constant, 7}, 0},
  {:negative_keyword, 0},
  {{:constant, 7}, 0},
  {:close_paren, 0},
  {:semicolon, 0},
  {:close_brace, 0}
]),
arbol_binario5: Parser.parse_program([
  {:int_keyword, 0},
  {:main_keyword, 0},
  {:open_paren, 0},
  {:close_paren, 0},
  {:open_brace, 0},
  {:return_keyword, 0},
  {:open_paren, 0},
  {{:constant, 5}, 0},
  {:negative_keyword, 0},
  {{:constant, 4}, 0},
  {:negative_keyword, 0},
  {:open_paren, 0},
  {{:constant, 7}, 0},
  {:negative_keyword, 0},
  {{:constant, 7}, 0},
  {:close_paren, 0},
  {:close_paren, 0},
  {:semicolon, 0},
  {:close_brace, 0}
]),
arbol_binario6: Parser.parse_program([
  {:int_keyword, 0},
  {:main_keyword, 0},
  {:open_paren, 0},
  {:close_paren, 0},
  {:open_brace, 0},
  {:return_keyword, 0},
  {:open_paren, 0},
  {{:constant, 5}, 0},
  {:negative_keyword, 0},
  {{:constant, 4}, 0},
  {:negative_keyword, 0},
  {:open_paren, 0},
  {{:constant, 7}, 0},
  {:negative_keyword, 0},
  {{:constant, 7}, 0},
  {:close_paren, 0},
  {:close_paren, 0},
  {:semicolon, 0},
  {:close_brace, 0}
])
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
    ]) == state[:error2]
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



test "sin return", state do
  assert Parser.parse_program([
    {:int_keyword, 0},
    {:main_keyword, 0},
    {:open_paren, 0},
    {:close_paren, 0},
    {:open_brace, 0},
    {:complement_keyword, 0},
    {:negative_logical, 0},
    {{:constant, 4}, 0},
    {:semicolon, 0},
    {:close_brace, 0}
  ]) == state[:error1]
end

test "Arbol con operaciones unitarias", state do
  assert Parser.parse_program([
  {:int_keyword, 0},
  {:main_keyword, 0},
  {:open_paren, 0},
  {:close_paren, 0},
  {:open_brace, 0},
  {:return_keyword, 0},
  {:complement_keyword, 0},
  {:negative_logical, 0},
  {{:constant, 4}, 0},
  {:semicolon, 0},
  {:close_brace, 0}
]) == state[:arbol_unitary]
end
test "con negacion logica", state do
   assert "int  main (){return !2;}"
          |> Sanitizer.sanitize_source()
          |> Lexer.scan_words()
          |> Parser.parse_program() ==
            state[:arbol_unitary1]
end
test "con varios operadores unitarios", state do
   assert "int  main (){return -~!-2;}"
   |> Sanitizer.sanitize_source()
   |> Lexer.scan_words()
   |> Parser.parse_program() ==
   state[:arbol_unitary2]
 end
 test "con operadores y sin algunos tokens", state do
    assert "int  main-~!-2;}"
    |> Sanitizer.sanitize_source()
    |> Lexer.scan_words()
    |> Parser.parse_program() ==
    state[:arbol_unitary3]
  end
  #operadores binarios-------------------------------------------------------
  test "con varios operadores binarios", state do
     assert "int  main(){return (5-4-7-7)-10;}"
     |> Sanitizer.sanitize_source()
     |> Lexer.scan_words()
     |> Parser.parse_program() ==
     state[:arbol_binario1]
   end
   test "con varios operadores binarios y varios unitarios", state do
      assert "int  main(){return !-~(5-4-7-7);}"
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parse_program() ==
      state[:arbol_binario2]
    end
    test "con varios operadores binarios sin parentesis", state do
       assert "int  main(){return 5-4-7-7;}"
       |> Sanitizer.sanitize_source()
       |> Lexer.scan_words()
       |> Parser.parse_program() ==
       state[:arbol_binario3]
     end
     test "con varios operadores binarios con mas de 1 parentesis", state do
        assert "int  main(){return (5-4)-(7-7);}"
        |> Sanitizer.sanitize_source()
        |> Lexer.scan_words()
        |> Parser.parse_program() ==
        state[:arbol_binario4]
      end
      test "con varios operadores binarios con parentesis anidados", state do
         assert "int  main(){return (5-4-(7-7));}"
         |> Sanitizer.sanitize_source()
         |> Lexer.scan_words()
         |> Parser.parse_program() ==
         state[:arbol_binario5]
       end

end
