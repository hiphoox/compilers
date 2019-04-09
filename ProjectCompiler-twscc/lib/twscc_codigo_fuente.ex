defmodule Proyecto_compilador do #version 0.8,
  @moduledoc """
  Documentacion for proyecto_compilador.
  """
  def main(args) do

   case args do
      ["-h"] -> help() |> IO.puts();
      [path] -> if path =~ ".c", do: compile(path, :no_output), else: show_error(1) |> IO.puts;
      ["-s", path] -> compile(path, :gen_asm); #órden de generar asm
      ["-t", path] -> compile(path, :show_token); #mostrar tokens
      ["-a", path] -> compile(path, :show_ast); #mostrar AST
      ["-o", path, new_name] ->compile(path, new_name); #se recibe un nuevo nombre en vez de átomo
      _ -> show_error(1) |> IO.puts;
    end
  end

  defp compile(path, flag_or_name) do
    if path =~ ".c" and File.exists?(path) do
      #envío de la ruta y bandera al orquestador
       Orquestador.manager(path, flag_or_name);
     else
       show_error(3) |> IO.puts;
     end
  end

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
