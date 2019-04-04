defmodule Linker do
  def genera_archivo_binario(ruta_ensamblador) do
    nombre_archivo_ensamblador= Path.basename(ruta_ensamblador)##Returns the last component of the path or the path itself if it does not contain any directory separators
    nombre_archivo_binario = Path.basename(ruta_ensamblador, ".s")#Returns the last component of path with the extension stripped
    output_dir_name = Path.dirname(ruta_ensamblador)#Returns the directory component of path
    ruta_ensamblador = output_dir_name <> "/" <> nombre_archivo_ensamblador
    System.cmd("gcc", [nombre_archivo_ensamblador, "-o#{nombre_archivo_binario}"], cd: output_dir_name)
end
