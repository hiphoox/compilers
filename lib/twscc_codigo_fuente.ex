defmodule Proyecto_compilador do
  @moduledoc """
  Documentacion for proyecto_compilador.
  """

  ##para compilar mix escript.build
  #ejecuta ./twscc_compilador_c


  def main(_args) do ##no te quejes compilador

    ##SANEAMIENTO DE LA ENTRADA

    ##marzo 5, 2019

    IO.puts("Escaner del compilador. Lectura del codigo fuente");
    file_content=  File.read!("/home/eriq/compiladores/twscc/codigo_prueba_return.c"); ##lectura del archivo
    IO.inspect(file_content);
    ##dar por hecho que el codigo viene mal
    ##hacer un modulo de saneamiento de los datos
    ##validar ciertas cosas(si es un codigo fuente c, si no está corrupto, etc)
    ##reportar que algo está mal antes de procesarlo
    trimmed_content =  String.trim(file_content); ##borrara los saltos de linea antes y despues
    IO.inspect(trimmed_content);
    ##leer los tokens. Los numeros hacerles cast de String "2" a int 2
    ##Keyword, INT, simbolo_Especial, etc... (etiquetas)
    ##Implementar un autómata finito (AFD) usando expresiones regulares. Elixir ya tiene expresiones regulares
    ##\s+ --> haz match con un espacio y saltos de linea desde 1 hasta los que encuentre
    ##definicion de una expresion regular ~r/"expresion regular"/
    words = Regex.split(~r/\s+/, trimmed_content);
    IO.inspect(words);

    tokens_separados =  Lexer.scan_word(words);
    IO.inspect(tokens_separados);

    #DICHA LISTA DE SALIDA YA SALDRÁ EN ORDEN PARA CONSTRUIR

    ##ver todos los casos posibles para dividir, probando por ejemplo todo el codigo en el mismo renglon
    #"main(){return" buscar los tokens a identifiar (palabras reservadas: main, (, ), {, }, return, etc..)
    ##utilizar atomos para etiquetas (:main, :return) por ejemplo, la tupla del 2 {:integer, 2}
    ## para main: {:keyword o id, "main"}

  end

end
