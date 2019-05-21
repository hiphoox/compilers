defmodule Sanitizer do
  def sanitize_source(file_content) do
    trimmed_content = String.trim(file_content)
    words = Regex.split(~r/\s+/, trimmed_content)
    i = 0
    lista_sanitizer(words, i)
  end

  def lista_sanitizer(program, linea) when program != [] do
    lineaActual = hd(program)
    lineasSiguientes = tl(program)
    tokensNoNumerados = Regex.split(~r/\s+/, lineaActual, trim: true)
    tokensNumerados = Enum.flat_map(tokensNoNumerados, fn x -> [{x, linea}] end)
    linea = linea + 1
    otrostokens = lista_sanitizer(lineasSiguientes, linea)
    tokensNumerados ++ otrostokens
  end

  def lista_sanitizer(_program,_linea) do
    []
  end
end
