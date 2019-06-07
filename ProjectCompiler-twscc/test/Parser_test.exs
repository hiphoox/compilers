defmodule ParserTest do
  use ExUnit.Case
  doctest Proyecto_compilador

  setup_all do
    {:ok,
     ast: {:ok, {:program, "program",
             {:function, "main",
              {:return_Keyword, "return", {:constant, 2, {}, {}}, {}}, {}}, {}}
             }}
  end

  test "Prueba 1 de Nora Sandler: árbol ast de un código que devuelve 2", state do
    token_list = Lexer.scan_word(File.read!("test/return_2.c"), :no_output);
    assert  Parser.parse_tokens(elem(token_list, 1), :no_output) == state[:ast]
  end

  test "Prueba 2 de Nora Sandler: árbol ast de un código que devuelve 100" do
    token_list = Lexer.scan_word(File.read!("test/multi_digit.c"), :no_output);
    assert  Parser.parse_tokens(elem(token_list, 1), :no_output) ==
      {:ok, {:program, "program",
              {:function, "main",
               {:return_Keyword, "return", {:constant, 100, {}, {}}, {}}, {}}, {}}}
  end

  test "Prueba 3 de Nora Sandler: código al cual le falta un paréntesis que cierra" do
    token_list = Lexer.scan_word(File.read!("test/missing_paren.c"), :no_output);
    assert  Parser.parse_tokens(elem(token_list, 1), :no_output) == {:error, "Error de sintáxis. Se esperaba ) y se encontró: {"}
  end

  test "Prueba 4 de Nora Sandler: Sin valor de retorno" do
    token_list = Lexer.scan_word(File.read!("test/missing_retval.c"), :no_output);
    assert  Parser.parse_tokens(elem(token_list, 1), :no_output) == {:error, "Error de sintaxis: Se esperaba una constante u operador y se encontró ;."}
  end

  test "Código al cual le falta la expresión return" do
    token_list = Lexer.scan_word("\n\tint main(\n ) { \n \t2; }", :no_output);
    assert  Parser.parse_tokens(elem(token_list, 1), :no_output) == {:error, "Error de sintáxis. Se esperaba return y se encontró: (vacío)"}
  end

  test "Prueba 5 de Nora Sandler: Unario, negacion lógica" do
    token_list = Lexer.scan_word(File.read!("test/not_twelve.c"), :no_output);
    assert  Parser.parse_tokens(elem(token_list, 1), :no_output) ==
      {:ok, {:program, "program",
             {:function, "main",
              {:return_Keyword, "return",
               {:logicalNeg_Keyword, "!", {:constant, 12, {}, {}}, {}}, {}}, {}}, {}}}
  end

  test "Prueba 6 de Nora Sandler: Unario, complemento del 0" do
    token_list = Lexer.scan_word(File.read!("test/bitewise_zero.c"), :no_output);
    assert  Parser.parse_tokens(elem(token_list, 1), :no_output) ==
      {:ok, {:program, "program",
             {:function, "main",
              {:return_Keyword, "return",
               {:bitewise_Keyword, "~", {:constant, 0, {}, {}}, {}}, {}}, {}}, {}}}
  end

  test "Prueba 7 de Nora Sandler: Unario, numero negativo" do
    token_list = Lexer.scan_word(File.read!("test/neg.c"), :no_output);
    assert  Parser.parse_tokens(elem(token_list, 1), :no_output) ==
      {:ok, {:program, "program",
             {:function, "main",
              {:return_Keyword, "return",
               {:negation_Keyword, "-", {:constant, 5, {}, {}}, {}}, {}}, {}}, {}}}
  end

  test "Prueba 8 de Nora Sandler: Operadores unarios anidados" do
    token_list = Lexer.scan_word(File.read!("test/nested_ops.c"), :no_output);
    assert  Parser.parse_tokens(elem(token_list, 1), :no_output) ==
      {:ok, {:program, "program",
             {:function, "main",
              {:return_Keyword, "return",
               {:logicalNeg_Keyword, "!",
                {:negation_Keyword, "-", {:constant, 3, {}, {}}, {}}, {}}, {}}, {}}, {}}}
  end

  test "Prueba 9 de Nora Sandler: Operadores unarios anidados 2" do
    token_list = Lexer.scan_word(File.read!("test/nested_ops_2.c"), :no_output);
    assert  Parser.parse_tokens(elem(token_list, 1), :no_output) ==
      {:ok, {:program, "program",
             {:function, "main",
              {:return_Keyword, "return",
               {:negation_Keyword, "-",
                {:bitewise_Keyword, "~", {:constant, 0, {}, {}}, {}}, {}}, {}}, {}}, {}}}
  end

  test "Prueba 10 de Nora Sandler: Cero negado" do
    token_list = Lexer.scan_word(File.read!("test/not_zero.c"), :no_output);
    assert  Parser.parse_tokens(elem(token_list, 1), :no_output) ==
      {:ok, {:program, "program",
             {:function, "main",
              {:return_Keyword, "return",
               {:logicalNeg_Keyword, "!", {:constant, 0, {}, {}}, {}}, {}}, {}}, {}}}
  end

  test "Prueba 11 INVÁLIDA de Nora Sandler: Sin punto y coma" do
    token_list = Lexer.scan_word(File.read!("test/missing_semicolon.c"), :no_output);
    assert  Parser.parse_tokens(elem(token_list, 1), :no_output) == {:error, "Error de sintáxis. Se esperaba ; y se encontró: }"}
  end

  test "Prueba 12 de Nora Sandler: Operadores anidados sin constante." do
    token_list = Lexer.scan_word(File.read!("test/nested_missing_const.c"), :no_output);
    assert  Parser.parse_tokens(elem(token_list, 1), :no_output) == {:error, "Error de sintaxis: Se esperaba una constante u operador y se encontró ;."}
  end

  test "Prueba 12 de Nora Sandler: Operadores en desorden." do
    token_list = Lexer.scan_word(File.read!("test/wrong_order.c"), :no_output);
    assert  Parser.parse_tokens(elem(token_list, 1), :no_output) == {:error, "Error de sintaxis: Falta el segundo operando después de -."}
  end


end
