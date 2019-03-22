defmodule Orquestador do

  def manager(arg, file_adress) do

    IO.puts("\nLectura del codigo fuente (ORQUESTADOR):");
    file_content=  File.read!(file_adress); ##lectura del archivo
    #IO.inspect(file_content);

    #llamada al modulo de lexer
    tokens_separados =  Lexer.scan_word(file_content, 1);
    IO.inspect(tokens_separados);

    ##llamada al PARSER

    ##llamada al

    #DICHA LISTA DE SALIDA YA SALDRÁ EN ORDEN PARA CONSTRUIR

    ##ver todos los casos posibles para dividir, probando por ejemplo todo el codigo en el mismo renglon
    #"main(){return" buscar los tokens a identifiar (palabras reservadas: main, (, ), {, }, return, etc..)
    ##utilizar atomos para etiquetas (:main, :return) por ejemplo, la tupla del 2 {:integer, 2}
    ## para main: {:keyword o id, "main"}

  end

end
