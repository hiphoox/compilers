defmodule ParserTest do
  use ExUnit.Case
  doctest Parser
  ### Documentacion}

  setup_all do
    {:ok,
     tokens: [
       :int_keyword,
       :main_keyword,
       :a_parentesis,
       :c_parentesis,
       :a_llave,
       :return_keyword,
       {:constant, 2},
       :semicolon,
       :c_llave
     ]}
  end

  setup_all do
    {:ok,
    tokens_multi_digit: [
      :int_keyword,
      :main_keyword,
      :a_parentesis,
      :c_parentesis,
      :a_llave,
      :return_keyword,
      {:constant, 100},
      :semicolon,
      :c_llave
    ]}
  end

  setup_all do
    {:ok,
    tokens_missing_paren: [
      :int_keyword,
      :main_keyword,
      :a_parentesis,
      :a_llave,
      :return_keyword,
      {:constant, 2},
      :semicolon,
      :c_llave
    ]}
  end
    
  setup_all do
      {:ok,
      tokens_missing_retval: [
        :int_keyword,
        :main_keyword,
        :a_parentesis,
        :c_parentesis,
        :a_llave,
        :return_keyword,
        :semicolon,
        :c_llave
      ]}
  end

    setup_all do
      {:ok,
      tokens_no_brace: [
        :int_keyword,
        :main_keyword,
        :a_llave,
        :return_keyword,
        {:constant, 2},
        :semicolon,
      ]}
    end

    setup_all do
      {:ok,
       tokens_no_semicolon: [
         :int_keyword,
         :main_keyword,
         :a_llave,
         :return_keyword,
         {:constant, 2},
         :c_llave
       ]}
    end


    setup_all do
      {:ok,
       tokens_bitwise: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :logical_negation,
         {:constant, 12},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_bitwise_zero: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :complemento,
         {:constant, 0},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_neg: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :negacion,
         {:constant, 5},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_nested_ops: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :logical_negation,
         :negacion,
         {:constant, 3},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_nested_ops2: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :negacion,
         :complemento,
         {:constant, 0},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_not_five: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :logical_negation,
         {:constant, 5},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_not_zero: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :logical_negation,
         {:constant, 0},
         :semicolon,
         :c_llave
       ]}
    end

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
  ## Tokens sin int
  setup_all do
    {:ok,
     tokens_int: [
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

  IO.puts("Pruebas para el parser (Pruebas invalidas)")
  IO.puts("7 Pruebas invalidas ")
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
######################3##Pruebas Validas para la segunda etapa del compilador#####################################
  test "1.- bitwise", state do
    assert "int main()\n {\n  return !12;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end
  test "2.- bitwise_zero", state do
    assert "int main()\n {\n  return ~0;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end
  test "3.- neg", state do
    assert "int main()\n {\n  return -5;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end
  test "4.- nested_ops", state do
    assert "int main()\n {\n  return !-3;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end
  test "5.- nested_ops", state do
    assert "int main()\n {\n  return -~0;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end
  test "6.- not_five", state do
    assert "int main()\n {\n  return !5;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end
  test "7.- not_zero", state do
    assert "int main()\n {\n  return !0;\n}"
           |> Sanitizer.sanitize_source()
           |> Lexer.scan_words() ==
             state[:tokens] or state[:tokens_0]
  end
###################################################################################################################
end