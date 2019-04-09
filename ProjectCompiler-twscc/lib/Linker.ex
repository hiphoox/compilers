defmodule Linker do
  def binary_output(asm, flag, path) do
    case asm do
      #la variable ASM traerá el error acarreado o bien, el string del ensamblador generado
      #imprime en pantalla el motivo del error
      {:error, _} -> IO.inspect(elem(asm, 1), label: "ERROR ")
      _ -> generate_exe_or_asm(asm, flag, path)
    end

  end
end
