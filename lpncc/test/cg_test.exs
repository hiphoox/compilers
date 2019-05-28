#defmodule Generador_CodigoTest do
#    use ExUnit.Case
#    doctest CodeGenerator
#    ### Documentacion}
#    setup_all do
#      {:ok,
#       tokens: [
#         :int_keyword,
#         :main_keyword,
#         :open_paren,
#         :close_paren,
#         :open_brace,
#         :return_keyword,
#        {:constant, 2},
#         :semicolon,
#         :close_brace
#       ],
#       tokens2: [
#         :int_keyword,
#         :main_keyword,
#         :open_paren,
#         :close_paren,
#         :open_brace,
#         :return_keyword,
#         {:constant, 0},
#         :semicolon,
#         :close_brace
#       ]}
#    end
#  
#    IO.puts("Pruebas para el Code Generator (Pruebas invalidas)")
#    IO.puts("7 Pruebas invalidas ")
#  
#    test "1.- Prueba", state do
#      assert "int main() return 2;}"
#             |> Sanitizer.sanitize_source()
#             |> Lexer.scan_words()
#             |> Parser.parseo()
#             |> CodeGenerator.generate_code() ==
#               {:error, "Falta una llave"}
#    end
#end