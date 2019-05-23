defmodule Lpncc do
  @moduledoc """
  Documentation for Lpncc.
  """

  @commands %{
    "h o help" => "Imprimi esta ayuda",
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
    print_lista_tokens(file_name)
  end
  defp process_args({[tree: file_name],_, _}) do
    print_lista_tokens(file_name)
  end

  defp process_args({[o: true],[nuevo_nombre,file_name],_}) do
    compile_file_with_new_name(nuevo_nombre, file_name)
  end

  defp process_args({[a: file_name],_, _}) do
    print_AST(file_name)
  end

  defp process_args({[ast: file_name],_, _}) do
    print_AST(file_name)
  end

  defp process_args({[s: file_name],_, _}) do
  print_Assembly(file_name)
  end

  defp process_args({[asm: file_name],_, _}) do
  compile_file(file_name)
  end


  defp compile_file(file_path) do
    IO.puts("Compiling file: " <> file_path)
    assembly_path = String.replace_trailing(file_path, ".c", ".s")
    lista_tokens=File.read!(file_path)
    |> Sanitizer.sanitize_source()
    |> Lexer.scan_words()
    evaluar=Evaluator.evaluator_lexer(lista_tokens)
    if evaluar==[] do
      arbolAST=lista_tokens
      |> Parser.parse_program()
      if is_map(arbolAST) do
        arbolAST
        |> CodeGenerator.generate_code()
        |> Linker.generate_binary(assembly_path)
        |> IO.inspect()
      end
      if is_tuple(arbolAST) do
        IO.puts("ERROR SINTACTICO")
        {_,_,linea_numero,problema_atomo}=arbolAST
        linea=to_string(linea_numero+1)
        problema=to_string(problema_atomo)
        mensaje_error="Errror en linea:  "<>linea<>", Cerca de: "<>problema
        IO.inspect(mensaje_error)
      end
    else
      IO.puts("Error lexico:")
      [_,palabra,linea_numero]=evaluar
      linea=to_string(linea_numero+1)
      mensaje_error="La  "<>palabra<>" es no esperada  en linea: "<>linea
      IO.inspect(mensaje_error)
    end
end

defp compile_file_with_new_name(newName,file_path) do
IO.puts("Compiling file: " <> file_path)
basename = Path.basename(file_path)
assembly_path = String.replace(file_path,basename,newName)

lista_tokens=File.read!(file_path)
|> Sanitizer.sanitize_source()
|> Lexer.scan_words()
evaluar=Evaluator.evaluator_lexer(lista_tokens)
if evaluar==[] do
  arbolAST=lista_tokens
  |> Parser.parse_program()
      if is_map(arbolAST) do
        arbolAST
        |> CodeGenerator.generate_code()
        |> Linker.generate_binary(assembly_path <> ".s")
        |> IO.inspect()
      else
        IO.puts("ERROR SINTACTICO")
        {_,_,linea_numero,problema_atomo}=arbolAST
        linea=to_string(linea_numero+1)
        problema=to_string(problema_atomo)
        mensaje_error="Errror en linea:  "<>linea<>", Cerca de: "<>problema
        IO.inspect(mensaje_error)
      end
else
    IO.puts("Error lexico:")
    [_,palabra,linea_numero]=evaluar
    linea=to_string(linea_numero+1)
    mensaje_error="La  "<>palabra<>" es no esperada  en linea: "<>linea
    IO.inspect(mensaje_error)
  end
end


  defp print_token_list(file_path) do
    IO.puts("\n TOKEN LIST \n")
    lista_tokens=File.read!(file_path)
    |> Sanitizer.sanitize_source()
    |> Lexer.scan_words()
    evaluar=Evaluator.evaluator_lexer(lista_tokens)
    if evaluar==[] do
      IO.inspect(lista_tokens)
    else
      IO.puts("Error lexico:")
      [_,palabra,linea_numero]=evaluar
      linea=to_string(linea_numero+1)
      mensaje_error="La  "<>palabra<>" es no esperada  en linea: "<>linea
      IO.inspect(mensaje_error)
    end
  end

  defp print_AST(file_path) do
    IO.puts("\n  AST TREE \n")
    lista_tokens=File.read!(file_path)
    |> Sanitizer.sanitize_source()
    |> Lexer.scan_words()
    evaluar=Evaluator.evaluator_lexer(lista_tokens)
    if evaluar==[] do
      arbolAST=lista_tokens
      |> Parser.parse_program()
      if is_map(arbolAST)do
        IO.inspect(arbolAST)
      end
      if is_tuple(arbolAST)do
        IO.puts("ERROR SINTACTICO")
        {_,_,linea_numero,problema_atomo}=arbolAST
        linea=to_string(linea_numero+1)
        problema=to_string(problema_atomo)
        mensaje_error="Errror en linea:  "<>linea<>", Cerca de: "<>problema
        IO.inspect(mensaje_error)
      end
    else
      IO.puts("Error lexico:")
      [_,palabra,linea_numero]=evaluar
      linea=to_string(linea_numero+1)
      mensaje_error="La  "<>palabra<>" es no esperada  en linea: "<>linea
      IO.inspect(mensaje_error)
    end
end

  defp print_Assembly(file_path) do
    IO.puts("\n  Assembly  \n")
    lista_tokens=File.read!(file_path)
    |> Sanitizer.sanitize_source()
    |> Lexer.scan_words()
    evaluar=Evaluator.evaluator_lexer(lista_tokens)
    if evaluar==[] do
      arbolAST=lista_tokens
      |> Parser.parse_program()
      if is_map(arbolAST) do
        arbolAST
        |> CodeGenerator.generate_code()
        |> IO.inspect()
      else
        IO.puts("ERROR SINTACTICO")
        {_,_,linea_numero,problema_atomo}=arbolAST
        linea=to_string(linea_numero+1)
        problema=to_string(problema_atomo)
        mensaje_error="Errror en linea:  "<>linea<>", Cerca de: "<>problema
        IO.inspect(mensaje_error)
      end
    else
      IO.puts("Error lexico:")
      [_,palabra,linea_numero]=evaluar
      linea=to_string(linea_numero+1)
      mensaje_error="La  "<>palabra<>" es no esperada  en linea: "<>linea
      IO.inspect(mensaje_error)
    end
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
