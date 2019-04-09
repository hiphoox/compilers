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

  end
