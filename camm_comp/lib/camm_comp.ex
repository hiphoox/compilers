defmodule CammComp do
  @moduledoc """
  Documentation for Compilador
  """
  @commands %{
  "help" => "Help",
  "t" => "Compiling only lexer",
  "a" => "Compiling only parser",
  "s" => "Compiling only assembler"
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

 defp process_args({ _, ["t" ,file_name], _}) do
   print_token_list(file_name)
 end

 defp process_args({ _, ["a" ,file_name], _}) do
   print_ast(file_name)
 end

 defp process_args({ _, ["s" ,file_name], _}) do
   print_assembler(file_name)
 end

 defp compile_file(file_path) do
   IO.puts("Compiling file: " <> file_path)
   assembly_path = String.replace_trailing(file_path, ".c", ".s")

   File.read!(file_path)
   |> Sanitizer.sanitize_source()
   |> IO.inspect(label: "\nSanitizer output")
   |> Lexer.scan_words()
   |> IO.inspect(label: "\nLexer output")
   |> Parser.parse_program()
   |> IO.inspect(label: "\nParser output")
   |> CodeGenerator.generate_code()
   |> IO.inspect(label: "\nGenertor output")
   |> Linker.generate_binary(assembly_path)
 end

 defp print_token_list(file_path) do
   IO.puts("Compiling file: " <> file_path)

   File.read!(file_path)
   |> Sanitizer.sanitize_source()
   |> Lexer.scan_words()
   |> IO.inspect(label: "\nLexer output")
 end

 defp print_ast(file_path) do
   IO.puts("Compiling file: " <> file_path)

   File.read!(file_path)
   |> Sanitizer.sanitize_source()
   |> Lexer.scan_words()
   |> Parser.parse_program()
   |> IO.inspect(label: "\nParser output")
 end

 defp print_assembler(file_path) do
   IO.puts("Compiling file: " <> file_path)

   File.read!(file_path)
   |> Sanitizer.sanitize_source()
   |> Lexer.scan_words()
   |> Parser.parse_program()
   |> CodeGenerator.generate_code()
   |> IO.inspect(label: "\nGenertor output")
 end

 defp print_help_message do
   IO.puts("\nCompilator --help file_name \n")

   IO.puts("\nThe compiler supports following options:\n")

   @commands
   |> Enum.map(fn {command, description} -> IO.puts("  #{command} - #{description}") end)
 end

end
