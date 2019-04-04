defmodule Orquestador do

  def manager(arg, file_adress) do
    try do
    file_content=  File.read!(file_adress); ##lectura del archivo
    tokens_separados =  Lexer.scan_word(file_content);
    ast = Parser.parsero(tokens_separados); #generación del árbol
    ensamblador=Generador_codigo.assembly(ast); #generación del código
    ruta_ensamblador = String.replace_trailing(file_adress, ".c", ".s");#se cambiará la extención del archivo en la ruta especificada
    #Linker.genera_archivo_binario(ensamblador,ruta_ensamblador);
    case arg do
      #nil  -> IO.inspect(ruta_ensamblador);
      "-t" -> IO.inspect(tokens_separados);
      "-a" -> IO.inspect(ast);
      "-s" -> IO.inspect(ensamblador)
      "--debug" -> IO.inspect(tokens_separados)
                   IO.inspect(ast);
                   IO.puts(ensamblador)
      nil -> :ok
    end
  rescue
  end

end
