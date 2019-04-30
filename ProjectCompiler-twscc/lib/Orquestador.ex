defmodule Orquestador do
  def manager(file, path, opt) do
  #Utilizando "with" se procesa el archivo. Si hay error se detiene.
  with  {:ok, tok} <- Lexer.scan_word(file, opt),
        {:ok, ast} <- Parser.parse_tokens(tok, opt),
        {:ok, asm} <- Generador_codigo.assembly(ast, opt, path),
        {:ok, _} <- Linker.binary_output(asm, opt, path)
        do
        IO.puts("Finalizó la compilación correctamente.")
  else
  #Se muestra el motivo del error o la salida de la opción seleccionada al compilar
        {:error, error} -> IO.puts(error)
        {:only_tokens, _} -> IO.puts("Lista de tokens.")
        {:only_ast, _} -> IO.puts("Árbol Sintáctico Abstracto.")
        {:only_asm, path_asm} ->IO.puts(path_asm)
      end
    end
end
