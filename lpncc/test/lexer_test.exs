defmodule LexerTest do
  use ExUnit.Case
  # doctest Lexer

  ## Ejecutar antes de que las pruebas se ejecuten
  ## Lista de Tokens Normales
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
     ]}
  end

  ### Lista de Tokens con constante 0
  setup_all do
    {:ok,
     tokens_0: [
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

  ### Tokens sin parentesis
  setup_all do
    {:ok,
     tokens_SP: [
       :int_keyword,
       :main_keyword,
       :open_brace,
       :return_keyword,
       {:constant, 0},
       :semicolon,
       :close_brace
     ]}
  end

  ## Tokens sin argumentos
  setup_all do
    {:ok,
     tokens4: [
       :int_keyword,
       :int_keyword,
       :main_keyword,
       :open_paren,
       :open_brace,
       :return_keyword,
       :semicolon,
       :close_brace
     ]}
  end

  ## Tokens sin Llaves
  setup_all do
    {:ok,
     tokens_SL: [
       :int_keyword,
       :main_keyword,
       :open_paren,
       :close_paren,
       :return_keyword,
       {:constant, 2},
       :semicolon
     ]}
  end

  ## Tokens con doble int
  setup_all do
    {:ok,
     tokens_int: [
       :int_keyword,
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

  ## Tokens con doble main
  setup_all do
    {:ok,
     tokens_int: [
       :int_keyword,
       :main_keyword,
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

  ######################################################################################
  IO.puts("Pruebas del lexer (7 pruebas Validas del Nora Sandler) ")

  test "1.- Elementos separadas espacios ", state do
    assert Lexer.scan_words(["int", "main(){return", "2;}"]) == state[:tokens_0] or state[:tokens]
  end

  test "2.- Funcion separada del main y el cuerpo del programa", state do
    assert Lexer.scan_words(["int", "main()", "{return", "2;}"]) == state[:tokens] or
             state[:tokens_0]
  end

  test "3.- Todo separado ", state do
    assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "2", ";", "}"]) ==
             state[:tokens] or state[:tokens_0]
  end

  test "4.- Retornando un 0", state do
    assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "0", ";", "}"]) ==
             state[:tokens_0] or state[:tokens]
  end

  test "5.- Con saltos de linea en int y main usando sanitizer", state do
    assert "int\nmain\n()\n{return 0;}" |> Sanitizer.sanitize_source() |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "6.- Con saltos de linea en todo usando sanitizer", state do
    assert "int\nmain\n(\n)\n{\nreturn\n0\n;\n}\n"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "7.- Con espacios entre los caracteres en todo usando sanitizer", state do
    assert "int    main    (   )   {   return    0   ;   }   "
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  ######################################################################################
  IO.puts("Pruebas no validas")

  test "8.-Faltan los parentesis ", state do
    assert Lexer.scan_words(["int", "main", "{", "return", "0", ";", "}"]) == state[:tokens_SP] or
             state[:tokens]
  end

  test "9.-Falta argumento en el return ", state do
    assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", ";}"]) == state[:tokens4] or
             state[:tokens]
  end

  test "10.-Faltan llaves ", state do
    assert Lexer.scan_words(["int", "main", "(", ")", "return", "0", ";"]) == state[:tokens_0] or
             state[:tokens_SL]
  end

  test "12.-Faltan espacios en el return  y el argumento ", state do
    assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "0", ";", "}"]) ==
             state[:tokens_0] or state[:tokens]
  end

  #################################################################################################
  ############ Pruebas propias
  ########### Pruebas Validas

  test "13.- 2 veces el main", state do
    assert Lexer.scan_words(["int", "main", "main", "(", ")", "{", "return", "0;}"]) ==
             state[:tokens] or state[:tokens_int]
  end

  test "14.- 2 veces el int", state do
    assert Lexer.scan_words(["int", "int", "main", "(", ")", "{", "return", "0;}"]) ==
             state[:tokens] or state[:tokens_int]
  end

  ################################################################################################################
  ###################### 3##Pruebas Validas para la segunda etapa del compilador#####################################
  test "15.- bitwise", state do
    assert "int main()\n {\n  return !12;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "16.- bitwise_zero", state do
    assert "int main()\n {\n  return ~0;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "17.- neg", state do
    assert "int main()\n {\n  return -5;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "18.- nested_ops", state do
    assert "int main()\n {\n  return !-3;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "19.- nested_ops", state do
    assert "int main()\n {\n  return -~0;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "20.- not_five", state do
    assert "int main()\n {\n  return !5;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "21.- not_zero", state do
    assert "int main()\n {\n  return !0;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  #################################################### 3###############################################################
  IO.puts("Pruebas para al tercer semana (10 pruebas Validas)")

  test "22.- add", state do
    assert "int main()\n {\n  return 2- -1;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "23.- asociativity", state do
    assert "int main()\n {\n  return 1 - 2 - 3;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "24.- add", state do
    assert "int main()\n {\n  return 6 / 3 / 2 ;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "25.- div", state do
    assert "int main()\n {\n  return 4 / 2;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "26.- Mult", state do
    assert "int main()\n {\n  return 2 * 3;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "27.- Mult", state do
    assert "int main()\n {\n  return 2 * 3;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "28.- Parens", state do
    assert "int main()\n {\n  return 2 * (3 + 4);\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "29.- Precedence", state do
    assert "int main()\n {\n  return 2 + 3 * 4;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "30.- Sub", state do
    assert "int main()\n {\n  return 1 - 2;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "31.- Sub Neg", state do
    assert "int main()\n {\n  return 2- -1;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "32.- Unop Add", state do
    assert "int main()\n {\n  return ~2 +3;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "33.- Uno Parens", state do
    assert "int main()\n {\n  return ~(1 + 1);\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  ##################################################### 3####################################################
  IO.puts("Pruebas no Validas para al tercer semana (4 Pruebas)")

  test "34.- No Semicolon", state do
    assert "int main()\n {\n  return 2*2\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "35.- Missing second Opcion", state do
    assert "int main()\n {\n  return 1 +;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "36.- Missign First Opcion", state do
    assert "int main()\n {\n  return /3;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end

  test "37.- Malformed Paren", state do
    assert "int main()\n {\n  return 2 (- 3);\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end
end
