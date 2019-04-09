defmodule Lpncc do
  @moduledoc """
  Documentation for Lpncc.
  """

  @commands %{
    "help" => "Imprimi est ayuda",
    "s"    => "Imprime el codigo en ensamblador del programa ",
    "o"    => "Para nombrar el codigo ejecutable",
    "t"    => "Para nombrar el codigo ejecutable",
    "a"    => "Para nombrar el codigo ejecutable"
   }

  def main(args) do
    args
    |> parse_args
    |> process_args
  end

  def parse_args(args) do
    OptionParser.parse(args, switches: [help: :boolean])
  end

  defp process_args({[help: true], _, _}) do
    print_help_message()
  end


  defp process_args({_, [file_name], _}) do
    compile_file(file_name)
  end

  defp process_args({[t: file_name],_, _}) do
    lista_tokens(file_name)
  end


  defp process_args({[a: file_name],_, _}) do
    parser(file_name)
  end

  defp process_args({[s: file_name],_, _}) do
  ensamblador(file_name)
  end

  
  defp compile_file(file_path) do
    IO.puts("Compiling file: " <> file_path)
    assembly_path = String.replace_trailing(file_path, ".c", ".s")

    File.read!(file_path)
    |> Sanitizer.sanitize_source()
    |> IO.inspect(label: "\nSanitizer ouput")
    |> Lexer.scan_words()
    |> IO.inspect(label: "\nLexer ouput")
    |> Parser.parseo()
    |> IO.inspect(label: "\nParser ouput")
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
  end


  defp print_help_message do
    IO.puts("\nLpncc --help Archivo de Ayuda \n")

    IO.puts("\nThe compiler supports following options:\n")
    IO.puts("\n -s muestra el codigo ensamblador del programa ")
    IO.puts("\n -a muestra el arbol AST \n")
    IO.puts("\n -t muestra la lisa de tokens")
    @commands
    |> Enum.map(fn {command, description} -> IO.puts("  #{command} - #{description}") end)
  end
end

"""
  def main(_args) do
    file_content=File.read!("Pruebas/return_2.c") 
    trimmed_content=String.trim(file_content)
    words = Regex.split(~r/\s+/,trimmed_content)
    tokens=Lexer.scan_words(words)
    #ast=Parser.parseo(tokens)
    #IO.puts(ast) 
    #IO.inspect(label: "\nParser ouput")
    #CodeGenerator.generate_code()
    #IO.puts(words)
    #IO.inspect(tokens) #Loguardaenunalista
  end
"""
