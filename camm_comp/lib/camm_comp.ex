defmodule CammComp do
  @moduledoc """
  Documentation for Compilador
  """
  def main(_args) do
    file_content = File.read!("examples/e1.c")  # entre las comillas va la ubicación del archivo a asignar
    trimmed_content = String.trim(file_content)  # saneamiento de codigo para exceso de espacios, tabulaciones
    words = Regex.split(~r/\s+/,trimmed_content) # virulilla ‘r’ para declarar una expresión regular y se encierra en diagonales, woords es nuestra lista
    tokens  = Lexer.scan_words(words)
    IO.inspect(tokens)
  end
end
