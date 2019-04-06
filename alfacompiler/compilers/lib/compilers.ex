defmodule Compilers do
  @moduledoc """
  Documentation for Compilers.
  """


def main(_args) do
  file_content = File.read!("examples/return_2.c")
  trimmed_content = String.trim(file_content)
  words = Regex.split(~r/\s+/, trimmed_content)
  tokens = Lexer.scan_words(words)
  IO.inspect(tokens)
end

  defp mensajeAyuda do
    IO.puts("Las opciones de uso del compilador son: \n ");
    IO.puts("-t Se muestra la lista de tokens\n");
    IO.puts("-a Se muestra el árbol AST\n");
    IO.puts("-s Se muestra el codigo ensamblador \n");
    IO.puts("--debug Modo de depuración\n");


  end

end
