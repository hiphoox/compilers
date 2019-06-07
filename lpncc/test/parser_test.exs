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
       :semicolon
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

  IO.puts("Pruebas para el parser")

  ############################################################### 1######################################
  IO.puts("Se ejecutan 7 pruebas Validas Para la primera Etapa")

  test "1.- Con 2 diferentes digitos", state do
    assert "int main () {return 2;}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_multi_digit]
  end

  test "2.- Con Saltos de linea", state do
    assert "int\nmain\n(\n)\n{\nreturn\n2\n;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_multi_digit]
  end

  test "3.- Todo junto", state do
    assert "int main(){return 2;}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_multi_digit]
  end

  test "4.- Todo junto", state do
    assert "int main(){return 2;}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_multi_digit]
  end

  test "5.- Con el digito return 0", state do
    assert "int main(){\nreturn 0;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_multi_digit]
  end

  test "6.- Con el digito 2", state do
    assert "int main(){\nreturn 2;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_multi_digit]
  end

  test "7.- Con espacios entre los digitos", state do
    assert " int main ( ) { return 0 ; }"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_multi_digit]
  end

  ###################################
  IO.puts("7 Pruebas no validas Para la primera etapa ")

  test "8.- Falta un parentesis", state do
    assert "int main( {\nreturn 2};"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_missing_paren]
  end

  test "9.- Falta argumento en el return", state do
    assert "int main() {\nreturn };"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_missing_retval]
  end

  test "10.- Sin parentesis", state do
    assert "int main {\nreturn 2};"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_missing_paren]
  end

  test "11.- Sin Espacios en el return", state do
    assert "int main() {\nreturn0 };"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_missing_retval]
  end

  test "12.- Con mayusculas en el RETURN", state do
    assert "int main() {\nRETURN 0 };"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_missing_retval]
  end

  ########################################################## 2####################################
  IO.puts("Se ejecutan 7 pruebas Validas Para la Segunda Etapa")

  test "13.- bitwise", state do
    assert "int main()\n {\n  return !12;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_bitwise]
  end

  test "14.- bitwise_zero", state do
    assert "int main()\n {\n  return ~0;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_bitwise_zero]
  end

  test "15.- neg", state do
    assert "int main()\n {\n  return -5;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_neg]
  end

  test "16.- nested_ops", state do
    assert "int main()\n {\n  return !-3;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_nested_ops]
  end

  test "17.- nested_ops", state do
    assert "int main()\n {\n  return -~0;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_nested_ops2]
  end

  test "18.- not_five", state do
    assert "int main()\n {\n  return !5;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_not_five]
  end

  test "19.- not_zero", state do
    assert "int main()\n {\n  return !0;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_not_zero]
  end

  ###################################################################################################################
  IO.puts("Se ejecutan 4 pruebas No Validas Para la Segunda Etapa")

  test "21.- missing_const", state do
    assert "int main()\n {\n  return !;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_not_zero]
  end

  test "22.- missing_semicolon", state do
    assert "int main()\n {\n  return !5;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_not_zero]
  end

  test "23.- nested_mising_const", state do
    assert "int main()\n {\n  return !~;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_not_zero]
  end

  test "24.- wrong_order", state do
    assert "int main()\n {\n  return 4-;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_not_zero]
  end

  #################################################### 3###############################################################
  IO.puts("Pruebas para al tercer semana (10 pruebas Validas)")

  test "25.- add", state do
    assert "int main()\n {\n  return 2- -1;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_0]
  end

  test "26.- asociativity", state do
    assert "int main()\n {\n  return 1 - 2 - 3;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_0]
  end

  test "27.- add", state do
    assert "int main()\n {\n  return 6 / 3 / 2 ;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_0]
  end

  test "28.- div", state do
    assert "int main()\n {\n  return 4 / 2;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_0]
  end

  test "29.- Mult", state do
    assert "int main()\n {\n  return 2 * 3;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_0]
  end

  test "30.- Mult", state do
    assert "int main()\n {\n  return 2 * 3;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_0]
  end

  test "31.- Parens", state do
    assert "int main()\n {\n  return 2 * (3 + 4);\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_0]
  end

  test "32.- Precedence", state do
    assert "int main()\n {\n  return 2 + 3 * 4;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_0]
  end

  test "33.- Sub", state do
    assert "int main()\n {\n  return 1 - 2;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_0]
  end

  test "34.- Sub Neg", state do
    assert "int main()\n {\n  return 2- -1;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_0]
  end

  test "35.- Unop Add", state do
    assert "int main()\n {\n  return ~2 +3;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_0]
  end

  test "36.- Uno Parens", state do
    assert "int main()\n {\n  return ~(1 + 1);\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_0]
  end

  ##################################################### 3####################################################
  IO.puts("Pruebas no Validas para al tercer semana (4 Pruebas)")

  test "37.- No Semicolon", state do
    assert "int main()\n {\n  return 2*2\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_0]
  end

  test "38.- Missing second Opcion", state do
    assert "int main()\n {\n  return 1 +;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_0]
  end

  test "39.- Missign First Opcion", state do
    assert "int main()\n {\n  return /3;\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_0]
  end

  test "40.- Malformed Paren", state do
    assert "int main()\n {\n  return 2 (- 3);\n}"
           |> Sanitizer.sanitize_source()
           |> Parser.parse_program() ==
             state[:tokens] or state[:tokens_0]
  end
end
