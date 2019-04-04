defmodule Saneador do
  def fix_code_format(file_content) do
    ##adición de pattern matching para encontrar la función main antes de comenzar la limpieza
    is_main = (file_content =~ "main")
    if is_main do
        trimmed_content =  String.trim(file_content) ##borrara los saltos de linea antes y despues
        Regex.split(~r/\s+/, trimmed_content);
    else
        IO.puts("Código inválido: Falta la funcion main.");
      nil
    end
  end
end
