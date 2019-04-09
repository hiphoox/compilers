defmodule Compilers do
  @moduledoc """
  Documentation for Compilers.
  """


def main(args) do
   args
   |> parseando_args
   |> procesando_args

end

def parseando_args(args) do
  OptionParser.parse(args, switches: [help: :boolean])
end

defp procesando_args({[help: true],_,_}) do
  mensajeAyuda()
end

defp procesando_args({_, [file_name],_}) do
  compile_file(file_name)
end

  defp mensajeAyuda do
    IO.puts("Las opciones de uso del compilador son: \n ");
    IO.puts("-t Se muestra la lista de tokens\n");
    IO.puts("-a Se muestra el árbol AST\n");
    IO.puts("-s Se muestra el codigo ensamblador \n");
    IO.puts("--debug Modo de depuración\n");


  end


  defp compile_file(file_path) do
    IO.puts("Compiling file: " <> file_path)
    assembly_path = String.replace_trailing(file_path, ".c", ".s")

    File.read!(file_path)
    |> Saneador.limpiado()
    |> IO.inspect(label: "\nSanitizer ouput")
    |> Lexer.scan_words()
    |> IO.inspect(label: "\nLexer ouput")
    |> Parser.parse_program()
    |> IO.inspect(label: "\nParser ouput")
    |> CodeGenerator.generate_code()
    |> Linker.generate_binary(assembly_path)
  end

  def call_nora_test(string) do
    IO.puts("El programa a compilar es")
      IO.puts(string)
      tokens_separados =  Lexer.scan_words(string); #lista de tokens
      ast = Parser.parse_function(tokens_separados); #genera AST
      #Generador_codigo.assembly(ast,file_address)|>Linker.genera_archivo_binario();
      IO.inspect(tokens_separados);
      IO.inspect(ast);
      #Generador_codigo.assembly(ast,file_address)|>Linker.genera_archivo_binario();
      :ok
    end

end
