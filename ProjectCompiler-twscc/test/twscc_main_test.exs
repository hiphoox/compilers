defmodule MainTest do
  use ExUnit.Case
  doctest Proyecto_compilador

  test "Archivo inexistente en el directorio" do
    assert Proyecto_compilador.compile("/codigo_inexistente.c", :no_output) == "Archivo inválido o no existe en el directorio."
  end

  test "Argumentos inválidos del programa (--token -o codigo.c)" do
    assert Proyecto_compilador.main(["--token", "-o", "codigo.c"]) == "Compilador de C de twscc. Escriba -h para la ayuda."
  end
end
