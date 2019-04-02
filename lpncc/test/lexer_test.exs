defmodule LexerTest do
  use ExUnit.Case
  #doctest Lexer

  ##Ejecutar antes de que las pruebas se ejecuten
  setup_all do
    {:ok,
     tokens: [ ###Lista de tokens que devuelve el lexer
       :int_keyword,
       :main_keyword,
       :open_paren,
       :close_paren,
       :open_brace,
       :return_keyword,
       {:constant, 2},
       :semicolon,
       :close_brace
     ]}
  end

  test "elements separated just by spaces(Elementos separadas espacios)", state do
    assert Lexer.scan_words(["int", "main(){return", "2;}"]) == state[:tokens]
  end

  test "function name separated of function body", state do
    assert Lexer.scan_words(["int", "main()", "{return", "2;}"]) == state[:tokens]
  end

  test "everything is separated", state do
    assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "2", ";", "}"]) ==
             state[:tokens]
  end

  test "Todo junto en una sola cadena", state do
    assert Lexer.scan_words(["int main(){return 2; }"]) == state[:tokens]
  end

  test "Return Separado", state do
    assert Lexer.scan_words(["int", "main(){return 2;}"]) == state[:tokens]
  end
end
