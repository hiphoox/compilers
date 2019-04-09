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
       {:constant, 2},
       :semicolon,
       :close_brace],

       tokens0: [
       :int_keyword,
       :main_keyword,
       :open_paren,
       :close_paren,
       :open_brace,
       :return_keyword,
       {:constant, 0},
       :semicolon,
       :close_brace
  ]}
  end

  test " :Separdos por espacios", state do
      assert Lexer.scan_words(["int", "main(){return", "2;}"]) ==
      state[:tokens] or state[:tokens0]
  end

  test " :La función esta separada del cuerpo", state do
      assert Lexer.scan_words(["int", "main()", "{return", "2;}"])==
      state[:tokens] or state[:tokens0]
  end

  test " :Todo esta separado", state do
      assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "2", ";", "}"]) ==
      state[:tokens] or state[:tokens0]
  end

  test " :Regresando un 0", state do
    assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "0", ";", "}"]) ==
    state[:tokens0] or state[:tokens]
  end

  test " :Usando saltos de linea en int y main", state do
     assert "int\nmain\n()\n{return 0;}" |> Sanitizer.sanitize_source() |> Lexer.scan_words() ==
     state[:tokens] or state[:tokens0]
  end

  test " :Usando saltos de linea en todo usando sanitizer", state do
     assert "int\nmain\n(\n)\n{\nreturn\n0\n;\n}\n"
            |> Sanitizer.sanitize_source()
            |> Lexer.scan_words() ==
              state[:tokens] or state[:tokens0]
  end

  test " :Con espacios entre los caracteres en todo usando sanitizer", state do
     assert "int    main    (   )   {   return    0   ;   }   "
            |> Sanitizer.sanitize_source()
            |> Lexer.scan_words() ==
              state[:tokens] or state[:tokens0]
  end

  # Más pruebas

  test " :Una sola cadena", state do
    assert Lexer.scan_words(["intmain(){return10;}"]) ==
    state[:tokens] or state[:tokens0]
  end

  test " :Elementos separados por espacios", state do
    assert Lexer.scan_words(["int", "main(){return", "10;}"]) ==
    state[:tokens] or state[:tokens0]
  end

  test " :Separados en dos cadenas ", state do
    assert Lexer.scan_words(["intmain()","{return10;}"]) ==
    state[:tokens] or state[:tokens0]
  end

end
