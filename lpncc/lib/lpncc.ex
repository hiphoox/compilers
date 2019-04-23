defmodule Lpncc do
  @moduledoc """
  Documentation for Lpncc.
  """

  @commands %{
    "h o help" => "Imprimi est ayuda",
    "asm o s"    => "Imprime el codigo en ensamblador del programa ",
    "o"    => "Cambia el nombre del archivo",
    "tree o t"    => "Imprime la lista de tokens",
    "ast o a"    => "Imprime el arbol AST"
   }

  def main(args) do
    args
    |> parse_args
    |> process_args
  end

  def parse_args(args) do
    OptionParser.parse(args, switches: [help: :boolean, o: :boolean])
  end

  defp process_args({[help: true], _, _}) do
    print_help_message()
  end

  defp process_args({[h: true], _, _}) do
    print_help_message()
  end

  defp process_args({_, [file_name], _}) do
    compile_file(file_name)
  end

  defp process_args({[t: file_name],_, _}) do
    lista_tokens(file_name)
  end
  defp process_args({[tree: file_name],_, _}) do
    lista_tokens(file_name)
  end

  defp process_args({[o: file_name],[file_name, nuevo_nombre], _}) do
    compilar_con_nuevo_nombre(nuevo_nombre, file_name)
  end

  defp process_args({[a: file_name],_, _}) do
    parser(file_name)
  end

  defp process_args({[ast: file_name],_, _}) do
    parser(file_name)
  end

  defp process_args({[s: file_name],_, _}) do
  ensamblador(file_name)
  end

  defp process_args({[asm: file_name],_, _}) do
  ensamblador(file_name)
  end

  defp compile_file(file_path) do
    IO.puts("Compilando archivo: " <> file_path)
    assembly_path = String.replace_trailing(file_path, ".c", ".s")

    File.read!(file_path)
    |> Sanitizer.sanitize_source()
    |> Lexer.scan_words() #{:error , valor}
    |> Parser.parseo() #{:error ,falta main}
    |> CodeGenerator.generate_code()
    |> Linker.generate_binary(assembly_path)
  end

  defp compilar_con_nuevo_nombre(nuevo_nombre, file_name) do
    IO.puts("Compilando Archivo: " <> file_name)
    nombre_actual = Path.basename(file_name)
    assembly_path = String.replace(file_name,nombre_actual,nuevo_nombre)

    File.read!(file_name)
    |> Sanitizer.sanitize_source()
    |> IO.inspect(label: "\nSalida sanitizer:")
    |> Lexer.scan_words()
    |> IO.inspect(label: "\nSalida Lexer:")
    |> Parser.parseo()
    |> IO.inspect(label: "\nSalida Parser: ")
    |> CodeGenerator.generate_code()
    |> Linker.generate_binary(assembly_path)
  end

  defp  lista_tokens(file_path) do
    File.read!(file_path)
    |> Sanitizer.sanitize_source()
    |> Lexer.scan_words()
    |> IO.inspect(label: "\nLista de Tokens")
  end


  defp parser(file_path) do
    File.read!(file_path)
    |> Sanitizer.sanitize_source()
    |> Lexer.scan_words()
    |> Parser.parseo()
    |> IO.inspect(label: "\nSalida del Parser (AST)\n")
  end


  defp ensamblador(file_path) do
      File.read!(file_path)
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()
      |> Parser.parseo()
      |> CodeGenerator.generate_code()
      |> Stream.into("asm_code.s")

  end


  defp print_help_message do
    IO.puts("\nLpncc --help Archivo de Ayuda \n")

    IO.puts("\nEl compilador soporta las siguientes opciones:\n")
    IO.puts("\n --s  o --asm muestra el codigo ensamblador del programa ")
    IO.puts("\n --a o --ast muestra el arbol AST")
    IO.puts("\n --t o --tree muestra la lista de tokens")
    IO.puts("\n --o archivo con otro nombre")
    @commands
    |> Enum.map(fn {command, description} -> IO.puts("  #{command} - #{description}") end)
  end
end
