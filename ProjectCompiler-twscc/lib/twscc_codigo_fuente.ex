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
  defp help() do
    "
    Uso:\n ./twscc_compilador_c nombre del archivo.c | [option] nombre del archivo.c\n
    \b -t      Muestra en pantalla la lista de tokens.
    \b -a      Muestra el Árbol Sintáctico Abstracto.
    \b -s      Genera el código fuente del ensamblador (x86).
    \b -o [nombre del archivo] [nombre_ejecutable] Especifica el nombre del ejecutable a generar.
    "
  end

  defp show_error(num) do
     case num do
       1 -> "Compilador de C de twscc. Escriba -h para la ayuda." #no se puso argumento
       2 -> "Comando(s) no válido. Escriba -h para la ayuda." #mensaje de error
       3 -> "Archivo inválido o no existe en el directorio." #mensaje de archivo inválido
     end
   end
end
