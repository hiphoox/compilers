defmodule Orquestador do

  def manager(arg, file_address, new_file_name) do
    #lectura y proceso del archivo, la tupla de error se propaga entre funciones
    File.read!(path)
    |> Lexer.scan_word(opt)
    |> Parser.parse_tokens(opt)
    |> Generador_codigo.assembly(opt)
    |> Linker.binary_output(opt, path); #necesitas la ruta para extraer el nombre del archivo
    IO.puts("El compilador finalizó sin ningún error.")

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
