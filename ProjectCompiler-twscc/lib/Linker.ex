defmodule Linker do
  def binary_output(asm, flag, path) do
    case asm do
      #la variable ASM traerá el error acarreado o bien, el string del ensamblador generado
      #imprime en pantalla el motivo del error
      {:error, _} -> IO.inspect(elem(asm, 1), label: "ERROR ")
      _ -> generate_exe_or_asm(asm, flag, path)
    end

  end

  def generate_exe_or_asm(asm, flag, path) do
    case flag do
      :gen_asm    -> File.write!(String.replace_trailing(path, ".c", ".s"), asm)
                     IO.inspect(String.replace_trailing(path, ".c", ".s"), label: "Se generó correctamente el archivo de ensamblador ")

      :show_token -> File.write!(String.replace_trailing(path, ".c", ".s"), asm)
                     write_program(path);

      :show_ast   -> File.write!(String.replace_trailing(path, ".c", ".s"), asm)
                     write_program(path);

      :no_output  -> File.write!(String.replace_trailing(path, ".c", ".s"), asm)
                     write_program(path);
               _  -> File.write!(String.replace_trailing(path, ".c", ".s"), asm)
                     write_program(path, flag);
    end
  end

  #escribe en disco el programa con el mismo nombre que el código fuente
  def write_program(path) do
    program_name = Path.basename(path, ".c")
    dir_name = Path.dirname(path)
    asm_file_path = Path.basename(path, ".c")
    asm_file_path = asm_file_path <> ".s"
    System.cmd("gcc", [asm_file_path, "-o#{program_name}"], cd: dir_name)
    File.rm(asm_file_path)
    IO.puts ("Ejecutable generado, para ver la salida del programa: ./#{program_name}; echo $?")
  end
end
