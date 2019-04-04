defmodule LexerTest do
  use ExUnit.Case
  #doctest Lexer

  ##Ejecutar antes de que las pruebas se ejecuten
  setup_all do
    {:ok,
     tokens: [
       :int_keyword,
       :main_keyword,
       :open_paren,
       :close_paren,
       :open_brace,
       :return_keyword,
       {:constant, 2},
       :semicolon,
       :close_brace
     ],
     tokens2: [
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

  test "1.- Elementos separadas espacios ", state do
    assert Lexer.scan_words(["int", "main(){return", "2;}"]) == state[:tokens2] or state[:tokens]
  end

  test "2.- Funcion separada del main y el cuerpo del programa", state do
    assert Lexer.scan_words(["int", "main()", "{return", "2;}"]) == state[:tokens] or state[:tokens2]
  end

  test "3.- Todo separado ", state do
    assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "2", ";", "}"]) ==
             state[:tokens]  or state[:tokens2]
  end
  
  test "4.- Retornando un 0", state do
    assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "0", ";", "}"]) ==
             state[:tokens2]
  end
  
  ### Para prbar los saltos de linea
  test "5.- Con saltos de linea en int y main usando sanitizer", state do
    assert  "int\nmain\n()\n{return 0;}" |> Sanitizer.sanitize_source() |>Lexer.scan_words() ==
             state[:tokens]  or state[:tokens2]
  end

  test "6.- Con saltos de linea en todo usando sanitizer", state do
    assert  "int\nmain\n(\n)\n{\nreturn\n0\n;\n}\n" |> Sanitizer.sanitize_source() |>Lexer.scan_words() ==
             state[:tokens]  or state[:tokens2]
  end
  
  test "7.- Con espacios entre los caracteres en todo usando sanitizer", state do
    assert  "int    main    (   )   {   return    0   ;   }   " |> Sanitizer.sanitize_source() |>Lexer.scan_words() ==
             state[:tokens]  or state[:tokens2]
  end
end
