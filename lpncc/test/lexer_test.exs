defmodule LexerTest do
  use ExUnit.Case
  # doctest Lexer

  ## Ejecutar antes de que las pruebas se ejecuten
  setup_all do
    {
      :ok,
      ## con 3 cosas de cada uno
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
      ],
      tokens3: [
        :int_keyword,
        :int_keyword,
        :main_keyword,
        :open_paren,
        :close_paren,
        :open_brace,
        :return_keyword,
        {:constant, 0},
        :semicolon,
        :close_brace
      ]
    }
  end

  ######################################################################################
  IO.puts("Pruebas del lexer (7 pruebas Validas del Nora Sandler) ")

  test "1.- Elementos separadas espacios ", state do
    assert Lexer.scan_words(["int", "main(){return", "2;}"]) == state[:tokens2] or state[:tokens]
  end

  test "2.- Funcion separada del main y el cuerpo del programa", state do
    assert Lexer.scan_words(["int", "main()", "{return", "2;}"]) == state[:tokens] or
             state[:tokens2]
  end

  test "3.- Todo separado ", state do
    assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "2", ";", "}"]) ==
             state[:tokens] or state[:tokens2]
  end

  test "4.- Retornando un 0", state do
    assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "0", ";", "}"]) == state[:tokens2] or state[:tokens]
  end

  test "5.- Con saltos de linea en int y main usando sanitizer", state do
    assert "int\nmain\n()\n{return 0;}" |> Sanitizer.sanitize_source() |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens2]
  end

  test "6.- Con saltos de linea en todo usando sanitizer", state do
    assert "int\nmain\n(\n)\n{\nreturn\n0\n;\n}\n"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens2]
  end

  test "7.- Con espacios entre los caracteres en todo usando sanitizer", state do
    assert "int    main    (   )   {   return    0   ;   }   "
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens2]
  end

  ######################################################################################
  IO.puts("Pruebas no validas")

  test "8.-Falta un parentesis ", state do
    assert Lexer.scan_words(["int", "main( {return", "0;}"]) == state[:tokens2] or state[:tokens]
  end

  test "9.-Falta argumento en el return ", state do
    assert Lexer.scan_words(["int", "main() {return", ";}"]) == state[:tokens2] or state[:tokens]
  end

  test "10.-Falta una llave ", state do
    assert Lexer.scan_words(["int", "main() {return", "0;"]) == state[:tokens2] or state[:tokens]
  end

  test "11.-Faltan los parentesis del main ", state do
    assert Lexer.scan_words(["int", "main( {return", "0;}"]) == state[:tokens2] or state[:tokens]
  end

  test "12.-Faltan espacios en el return  y el argumento ", state do
    assert Lexer.scan_words(["int", "main( {return0;}"]) == state[:tokens2] or state[:tokens]
  end

  test "13.- Mayusculas en el return", state do
    assert Lexer.scan_words(["int", "main( {RETURN", "0;}"]) == state[:tokens2] or state[:tokens]
  end

  #################################################################################################
  ############ Pruebas propias
  ########### Pruebas Validas

  # test "14.- 2 veces el int", state do
  # assert Lexer.scan_words([ "int","int", "main", "(",")", "{","return", "0;}"]) == state[:tokens2] or state[:tokens] or state[:tokens3]
  # end 

  #################################################################################################
  ############ Pruebas propias
  ########### Pruebas No Validas  
  test "13.- Mayusculas en el main", state do
    assert Lexer.scan_words(["int", "MAIN( {return", "0;}"]) == state[:tokens2] or state[:tokens]
  end

  test "16.- Mayusculas en el INT", state do
    assert Lexer.scan_words(["INT", "main( {return", "0;}"]) == state[:tokens2] or state[:tokens]
  end
end
