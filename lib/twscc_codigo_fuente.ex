defmodule Proyecto_compilador do
  @moduledoc """
  Documentacion for proyecto_compilador.
  """



  def main(argv) do

    IO.inspect(argv);
    case length(argv) do
      0 -> IO.puts("Compilador de C de twscc. Escriba --help para la ayuda.");
      1 -> is_help = Enum.at(argv, 0) =~ "--help";
           if is_help do
             help();
           else
             IO.puts("ERROR, comando inválido");
           end
      2 -> Orquestador.manager(Enum.at(argv, 0), Enum.at(argv, 1));
    end

  end
  #modulo de ayuda
  def help() do
    IO.puts("Usage:\n ./twscc_compilador_c [option] nombre del archivo.c")
    IO.puts("Options:\n")
    IO.puts("--n          Normal compilation (no console output)");
    IO.puts("--tokens     Prints in screen the list of tokens");
    IO.puts("--tree       Prints in screen the Abstract Syntax Tree");
    IO.puts("--asm        Generate the assembler .s file");
  end

end
