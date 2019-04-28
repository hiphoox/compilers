defmodule Orquestador do

  def manager(file, path, opt) do
    #lectura y proceso del archivo, la tupla de error se propaga entre funciones
  #archivo = File.read!(path)
#    |> Lexer.scan_word(opt)
#    |> Parser.parse_tokens(opt)
  #  |> Generador_codigo.assembly(opt)
  #  |> Linker.binary_output(opt, path); #necesitas la ruta para extraer el nombre del archivo
  #  IO.puts("El compilador finalizó sin ningún error.")

  with  {:ok, tok} <- Lexer.scan_word(file, opt),
        {:ok, ast} <- Parser.parse_tokens(tok, opt),
        {:ok, asm} <- Generador_codigo.assembly(ast, opt, path),
        {:ok, exe} <- Linker.binary_output(asm, opt, path)
        do
        IO.puts("Finalizó el programa")
  else
        {:error, error} -> IO.puts(error) #mostrar motivo del error
        {:only_tokens, _} -> IO.puts("TOKENS")
        {:only_ast, _} -> IO.puts("AST")
        {:only_asm,_} ->IO.puts("ASM")
        #err -> err
      end
    end
end
