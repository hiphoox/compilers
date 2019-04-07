defmodule CammComp do
  @moduledoc """
  Documentation for Compilador
  """
  def main(_args) do
    file_content = File.read!("examples/e1.c")  # entre las comillas va la ubicación del archivo a asignar
    trimmed_content = String.trim(file_content)  # saneamiento de codigo para exceso de espacios, tabulaciones
    words = Regex.split(~r/\s+/,trimmed_content) # virulilla ‘r’ para declarar una expresión regular y se encierra en diagonales, woords es nuestra lista
    tokens  = Lexer.scan_words(words)
    IO.inspect(tokens)
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

 defp compile_file(file_path) do
   IO.puts("Compiling file: " <> file_path)
   assembly_path = String.replace_trailing(file_path, ".c", ".s")

   File.read!(file_path)
   |> Sanitizer.sanitize_source()
   |> IO.inspect(label: "\nSanitizer ouput")
   |> Lexer.scan_words()
   |> IO.inspect(label: "\nLexer ouput")
   |> Parser.parse_program()
   |> IO.inspect(label: "\nParser ouput")
   |> CodeGenerator.generate_code()
   |> Linker.generate_binary(assembly_path)
 end

 defp print_help_message do
   IO.puts("\nnqcc --help file_name \n")

   IO.puts("\nThe compiler supports following options:\n")

   @commands
   |> Enum.map(fn {command, description} -> IO.puts("  #{command} - #{description}") end)
 end

end
