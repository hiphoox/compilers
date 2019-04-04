defmodule Proyecto_compilador do #version 0.8, falta arbol y generador de codigo
  @moduledoc """
  Documentacion for proyecto_compilador.
  """

  def main(argv) do
   case length(argv) do
      0 -> IO.puts("Compilador de C de twscc. Escriba -h para la ayuda.");
      1 -> if (Enum.at(argv, 0) =~ "-h") do
             help();
           else
             Orquestador.manager(nil, Enum.at(argv, 0), nil)
           end
           ##llamar al orquestador para comenzar proceso, envía bandera respectiva para la salida
      2 -> Orquestador.manager(Enum.at(argv, 0), Enum.at(argv, 1),nil);
      3 -> Orquestador.manager(Enum.at(argv, 0), Enum.at(argv, 1), Enum.at(argv,2))
    end
  end
  #modulo de ayuda
  def help() do
    IO.puts("Uso:\n ./twscc_compilador_c nombre del archivo.c | [option] nombre del archivo.c")
    IO.puts("Opciones:\n")
    IO.puts(" -t      Muestra en pantalla la lista de tokens");
    IO.puts(" -a      Muestra el Árbol Sintáctico Abstracto");
    IO.puts(" -s      Genera el código fuente del ensamblador (x86)");
    IO.puts(" --debug  Modo de depuración");
  end
end
