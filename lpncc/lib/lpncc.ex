defmodule Lpncc do
  @moduledoc """
  Documentation for Lpncc.
  """

   def main(_args) do
    file_content=File.read!("Pruebas/return_2.c") 
    trimmed_content=String.trim(file_content)
    words = Regex.split(~r/\s+/,trimmed_content)
    tokens=Lexer.scan_words(words)
    #IO.puts(words)
    IO.inspect(tokens) #Loguardaenunalista
  end
end
