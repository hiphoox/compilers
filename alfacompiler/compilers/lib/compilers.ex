defmodule Compilers do
  @moduledoc """
  Documentation for Compilers.
  """


@commands %{
  "help" => "Help",
  "t" => "Lexer",
  "a" => "Parser",
  "s" => "Assembly",
  "o  nombre_ejecutable" => "Cambio nombre ejecutable"
}


def main(args) do
   args
   |> parseando_args
   |> procesando_args

end

def parseando_args(args) do
  OptionParser.parse(args, switches: [help: :boolean])

end

defp procesando_args({_, [file_name],_}) do
  compile_file(file_name)
end


defp procesando_args({[help: true],_,_}) do
  print_help_message()
end


defp procesando_args({ _, ["t" ,file_name], _}) do
  lexer(file_name)
end



defp procesando_args({ _, ["s" ,file_name], _}) do
  assembly(file_name)
end

defp procesando_args({ _, ["a" ,file_name], _}) do
  parser(file_name)
end


defp procesando_args({ _, ["o" ,nombre_ejecutable, file_name], _}) do
 nuevoNombre(nombre_ejecutable, file_name)
end

#################        Banderas     ##############3
defp print_help_message do
  IO.puts("Bandera de AYUDA \n");
  IO.puts("Las opciones de uso del compilador son: \n");
  IO.puts("t Se muestra la lista de tokens\n");
  IO.puts("a Se muestra el árbol AST\n");
  IO.puts("s Se muestra el codigo ensamblador \n");
  IO.puts("o Se cambia el nombre del ejecutable ")


  @commands
  |> Enum.map(fn({command, description}) -> IO.puts("  #{command} - #{description}") end)
end



defp lexer(file_path) do
  IO.puts("Se imprimira la lista de Tokens")
    File.read!(file_path)
    |> Saneador.limpiado()
    |> Lexer.scan_words()

    |> IO.inspect(label: "\nGenerator Lexer")
end

defp  nuevoNombre(nombre_ejecutable, file_path) do
  IO.puts("Se imprimira la lista de Tokens")
  IO.puts("Compiling file: " <> file_path)
  basename = Path.basename(file_path)
  assembly_path = String.replace(file_path,basename,nombre_ejecutable)

  File.read!(file_path)
|> Saneador.limpiado()
|> Lexer.scan_words()
|> Parser.parse_program()
|> CodeGenerator.generate_code()
|> Linker.generate_binary(assembly_path <> ".s")
end


defp parser(file_path) do
  IO.puts("Se imprimira el Parser")
  File.read!(file_path)
  |> Saneador.limpiado()
  |> Lexer.scan_words()
  |> Parser.parse_program()
  |> IO.inspect(label: "\nParser output")
end

defp assembly(file_path) do
  IO.puts("Se imprimira el Ensamblador")
    File.read!(file_path)
    |> Saneador.limpiado()
    |> Lexer.scan_words()
    |> Parser.parse_program()
    |> CodeGenerator.generate_code()

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
    IO.puts("\n")
    IO.puts(string)
    tokens_separados =  Lexer.scan_words(string); #generación de Tokens
    ast = Parser.parse_function(tokens_separados); #generación del árbol
    IO.inspect(tokens_separados);
    IO.inspect(ast);
    :ok
   end

end
