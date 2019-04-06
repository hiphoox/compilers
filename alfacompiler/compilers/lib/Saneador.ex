
defmodule Saneador do
    def limpiando(file_content) do
      inicioMain = (file_content =~ "main")
      if inicioMain do
        ##Esto se hacia en el Inicio de la app
        ##
        trimmed_content = String.trim(file_content) ## Quita saltos
        Regex.split(~r/\s+/, trimmed_content);
      else
        IO.puts("Error: No se encontro función main");
      end

    end
end
