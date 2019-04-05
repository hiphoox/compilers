defmodule ParserTest do
  use ExUnit.Case
  doctest Parser
  ### Documentacion}
  setup_all do
    {:error, "Falla"}

    IO.puts("Pruebas para el parser")

    test "1.- Prueba", test do
      assert "int main()return 2;}"
             |> Sanitizer
             |> Lexer.scan_words()
             |> Parser.parseo()

      {:error, "Error, falta la llave"}
    end
  end
end