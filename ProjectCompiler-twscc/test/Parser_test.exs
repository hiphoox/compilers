defmodule ParserTest do
  use ExUnit.Case
  doctest Proyecto_compilador

  setup_all do
    {:ok,
     ast: {:program, "program",
             {:function, "main",
              {:return_Keyword, "return", {:constant, 2, {}, {}}, {}}, {}}, {}}
             }
  end

  test "Prueba 1 de Nora Sandler: árbol ast de un código que devuelve 2", state do
    token_list = Lexer.scan_word(File.read!("test/return_2.c"), :no_output);
    assert  Parser.parse_tokens(token_list, :no_output) == state[:ast]
  end

  test "Prueba 2 de Nora Sandler: árbol ast de un código que devuelve 100" do
    token_list = Lexer.scan_word(File.read!("test/multi_digit.c"), :no_output);
    assert  Parser.parse_tokens(token_list, :no_output) ==
      {:program, "program",
              {:function, "main",
               {:return_Keyword, "return", {:constant, 100, {}, {}}, {}}, {}}, {}}
  end

  test "Prueba 3 de Nora Sandler: código al cual le falta un paréntesis que cierra" do
    token_list = Lexer.scan_word(File.read!("test/missing_paren.c"), :no_output);
    assert  Parser.parse_tokens(token_list, :no_output) == {:error, "Error al parsear el elemento close_paren"}
  end

  test "Prueba 4 de Nora Sandler: Sin valor de retorno" do
    token_list = Lexer.scan_word(File.read!("test/missing_retval.c"), :no_output);
    assert  Parser.parse_tokens(token_list, :no_output) == {:error, "Error al parsear algun elemento de la expresion"}
  end

  test "Código al cual le falta la expresión return" do
    token_list = Lexer.scan_word("\n\tint main(\n ) { \n \t2; }", :no_output);
    assert  Parser.parse_tokens(token_list, :no_output) == {:error, "Error al parsear el elemento return_Keyword"}
  end

  test "Código vacío proveniente desde el Lexer" do
    token_list = Lexer.scan_word("", :no_output);
    assert  Parser.parse_tokens(token_list, :no_output) == {:error, "Código fuente vacío, nada por procesar"}
  end

end
