defmodule Compilers do
  @moduledoc """
  Documentation for Compilers.
  """


def main(args) do
   args
   |> parseando_args
   |> procesando_args

end

def parseando_args(args) do
  OptionParser.parse(args, switches: [help: :boolean])
end

defp procesando_args({[help: true],_,_}) do
  mensajeAyuda()
end

defp procesando_args({_, [file_name],_}) do
compilacion(file_name)
end




  defp mensajeAyuda do
    IO.puts("Las opciones de uso del compilador son: \n ");
    IO.puts("-t Se muestra la lista de tokens\n");
    IO.puts("-a Se muestra el árbol AST\n");
    IO.puts("-s Se muestra el codigo ensamblador \n");
    IO.puts("--debug Modo de depuración\n");


  end

  defp compilacion(file_name) do
    IO.puts("Compilando ... " <> file_name)
  File.read!(file_name)
  |> Saneador.limpiado()
  |> Lexer.scan_words()
  end

end
