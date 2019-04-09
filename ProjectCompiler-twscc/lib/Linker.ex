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
end
