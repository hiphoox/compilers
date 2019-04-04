defmodule Orquestador do

  def manager(arg, file_adress) do
    try do
    file_content= File.read!(file_address); ##lectura del archivo
    tokens_separados =  Lexer.scan_word(file_content); #generación de Tokens
    ast = Parser.main(tokens_separados); #generación del árbol

    case arg do
     nil  -> Generador_codigo.assembly(ast,file_address)|>Linker.genera_archivo_binario();
      "-t" -> IO.inspect(tokens_separados);
      "-a" -> IO.inspect(ast);
      "-s" -> Generador_codigo.assembly(ast,file_address);#generación del código
      "--debug" -> IO.inspect(tokens_separados)
                   IO.inspect(ast);
                   Generador_codigo.assembly(ast,file_address); #generación del código
    end
  rescue
    ##mostrar un mensaje de que no se pudo leer el archivo
    File.Error -> IO.puts("Error: no se pudo leer el archivo de código fuente. ¿Es correcta la ruta?");
    #FunctionClauseError -> IO.puts("Error: no se pudo generar el código ensamblador.");
  end
end
