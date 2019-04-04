defmodule Linker do
  def genera_archivo_binario(ruta_ensamblador) do
  nombre_archivo_ensamblador= Path.basename(ruta_ensamblador)
  nombre_archivo_binario=Path.basename(ruta_ensamblador,".s")
  output_dir_name = Path.dirname(ruta_ensamblador)
  output_dir_name <> "/" <> nombre_archivo_ensamblador
  System.cmd("gcc", [nombre_archivo_ensamblador, "-o#{nombre_archivo_binario}"], cd: output_dir_name)
  IO.inspect(nombre_archivo_binario, label: "Compilación correcta.\nSe generó tu ejecutable")
  IO.puts("Para ejecutarlo utiliza el siguiente comando: ./your_program; echo $?")
  :ok
  end
end
