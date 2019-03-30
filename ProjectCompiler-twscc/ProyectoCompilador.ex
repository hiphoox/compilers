defmodule Proyecto_compilador do

  def main(argv) do

    case length(argv) do
      0 ->
      1 ->
      2 ->
    end

  end
  
  def help() do
    IO.puts("Usage:\n ./twscc_compilador_c [option] nombre del archivo.c")
    IO.puts("Options:\n")
    IO.puts("--n          Normal compilation (no console output)");
    IO.puts("--tokens     Prints in screen the list of tokens");
    IO.puts("--tree       Prints in screen the Abstract Syntax Tree");
    IO.puts("--asm        Generate the assembler .s file");
  end


end
