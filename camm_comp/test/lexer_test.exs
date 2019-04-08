defmodule LexerTest do
  use ExUnit.Case
  doctest Lexer

  setup_all do
    {:ok,
     tokens: [
       :intkeyword,
       :mainkeyword,
       :open_parenthesis,
       :close_parenthesis,
       :open_brace,
       :returnkeyword,
       {:constant, 10},
       :semicolon,
       :close_brace
     ]}
  end

  test " :Separdos por espacios", state do
    assert Lexer.scan_words(["int", "main(){", "return10;", "}"]) ==
      state[:tokens]
  end

  test " :Una sola cadena", state do
    assert Lexer.scan_words(["intmain(){return10;}"]) ==
      state[:tokens]
  end

  test " :Elementos separados por espacios", state do
    assert Lexer.scan_words(["int", "main(){return", "10;}"]) ==
      state[:tokens]
  end

  test " :La función esta separada del cuerpo", state do
    assert Lexer.scan_words(["int", "main()", "{return", "10;}"]) ==
      state[:tokens]
  end

  test " :Todo esta separado", state do
    assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "10", ";", "}"]) ==
      state[:tokens]
  end

end
