defmodule Orquestador do

  def manager(arg, file_address, new_file_name) do
    try do

      file_content= File.read!(file_address); ##lectura del archivo
      tokens_separados =  Lexer.scan_word(file_content); #generación de Tokens
      ast = Parser.main(tokens_separados); #generación del árbol

      case arg do
        nil  -> Generador_codigo.assembly(ast,file_address)|> Linker.genera_archivo_binario();
        "-t" -> IO.inspect(tokens_separados);
        "-a" -> IO.inspect(ast);
        "-s" -> Generador_codigo.assembly(ast,file_address);#generación del código
        "--debug" -> IO.inspect(tokens_separados)
                     IO.inspect(ast);
                     Generador_codigo.assembly(ast,file_address) |> Linker.genera_archivo_binario(); #generación del código

        "-o" ->  Generador_codigo.assembly(ast,new_file_name);
      end
   rescue
    File.Error -> IO.puts("Error: no se pudo leer el archivo de código fuente. ¿Es correcta la ruta?");
   end
  end

  def manager_nora_test(string) do
    IO.puts("\n")
      IO.puts(string)
      tokens_separados =  Lexer.scan_word(string); #generación de Tokens
      ast = Parser.main(tokens_separados); #generación del árbol
      #Generador_codigo.assembly(ast,file_address)|>Linker.genera_archivo_binario();
      #IO.inspect(tokens_separados);
      IO.inspect(ast);
      #Generador_codigo.assembly(ast,file_address)|>Linker.genera_archivo_binario();
      :ok
    end
  end
