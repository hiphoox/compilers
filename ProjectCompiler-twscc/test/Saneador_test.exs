defmodule SaneadorTest do
  use ExUnit.Case
  doctest Proyecto_compilador

  setup_all do
     {:ok,
      sanity_error: {:error, "Error. Archivo código fuente vacío."} }
  end

  test "Código fuente vacío", state do
    assert Lexer.scan_word("", :show_token) == state[:sanity_error]
  end

end
