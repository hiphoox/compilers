defmodule Linker do
  def genera_archivo_binario(ensamblador, ruta_ensamblador) do
    ruta_ensamblador = Path.basename(ruta_ensamblador)##Returns the last component of the path or the path itself if it does not contain any directory separators
    nombre_archivo_binario = Path.basename(ruta_ensamblador, ".s")#Returns the last component of path with the extension stripped
    output_dir_name = Path.dirname(ruta_ensamblador)#Returns the directory component of path
    ruta_ensamblador = output_dir_name <> "/" <> ruta_ensamblador

    #File.write!(ruta_ensamblador, ensamblador)
    System.cmd("gcc", [ruta_ensamblador, "-o #{nombre_archivo_binario}"], cd: output_dir_name)
 #   File.rm!(ruta_ensamblador)
  end
end
