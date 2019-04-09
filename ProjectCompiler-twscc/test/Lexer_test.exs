defmodule LexerTest do
  use ExUnit.Case
  doctest Proyecto_compilador

  setup_all do
    {:ok,
     tokens: [
       :int_Keyword,
       :main_Keyword,
       :open_paren,
       :close_paren,
       :open_brace,
       :return_Keyword,
       {:constant, 2},
       :semicolon,
       :close_brace
     ]}
  end

  test "Elementos separados unicamente por espacios", state do
    assert Lexer.scan_word(" int main( ) { return 2; }", :no_output) == state[:tokens]
  end

  test "Elementos con saltos de línea y tabuladores", state do
    assert Lexer.scan_word("\n\tint main(\n ) { \nreturn \t2; }", :no_output) == state[:tokens]
  end

  test "Lista con elementos totalmente separados", state do
    assert Lexer.start_lexing(["int", "main", "(", ")", "{", "return", "2", ";", "}"], :no_output) == state[:tokens]
  end

  test "Lista con algunos elementos separados", state do
    assert Lexer.start_lexing(["int", "main()", "{", "return", "2", ";}"], :no_output) == state[:tokens]
  end

  test "Prueba 1 de Nora Sandler: código fuente sin espacios" do
    assert Lexer.scan_word(File.read!("test/spaces.c"), :no_output) == [
      :int_Keyword,
      :main_Keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_Keyword,
      {:constant, 0},
      :semicolon,
      :close_brace]
  end

  test "Prueba 2 de Nora Sandler: valor de retorno 2", state do
    assert Lexer.scan_word(File.read!("test/return_2.c"), :no_output) == state[:tokens]
  end

  test "Prueba 3 de Nora Sandler: valor de retorno 0" do
    assert Lexer.scan_word(File.read!("test/return_0.c"), :no_output) == [
      :int_Keyword,
      :main_Keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_Keyword,
      {:constant, 0},
      :semicolon,
      :close_brace]
  end

  test "Prueba 4 de Nora Sandler: Sin saltos de línea" do
    assert Lexer.scan_word(File.read!("test/no_newlines.c"), :no_output) == [
      :int_Keyword,
      :main_Keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_Keyword,
      {:constant, 0},
      :semicolon,
      :close_brace]
  end

  test "Prueba 5 de Nora Sandler: Valor de retorno 100 (múltiples dígitos) " do
    assert Lexer.scan_word(File.read!("test/multi_digit.c"), :no_output) == [
      :int_Keyword,
      :main_Keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_Keyword,
      {:constant, 100},
      :semicolon,
      :close_brace]
  end

  test "Prueba 6 de Nora Sandler: Con saltos de línea" do
    assert Lexer.scan_word(File.read!("test/new_line.c"), :no_output) == [
      :int_Keyword,
      :main_Keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_Keyword,
      {:constant, 0},
      :semicolon,
      :close_brace]
  end

  test "Prueba 7 de Nora Sandler: return en mayúsculas" do
    assert Lexer.scan_word(File.read!("test/wrong_case.c"), :no_output) == {:error, "La sintaxis en inválida."}
  end

end
