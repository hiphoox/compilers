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
        {:error, error} -> IO.puts(error) #mostrar motivo del error
        {:only_tokens, _} -> IO.puts("TOKENS")
        {:only_ast, _} -> IO.puts("AST")
        {:only_asm,_} ->IO.puts("ASM")
        #err -> err
      end
    end
end
