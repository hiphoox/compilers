defmodule Sanitizer do
  def sanitize_source(file_content) do
    trimmed_content = String.trim(file_content)
    lineasCod = Regex.split(~r/\s+/, trimmed_content)
    i = 0
    sanitizerList(lineasCod, i)
  end

  def sanitizerList(program, linea) when program != [] do
    lineaActual = hd(program)
    lineasSiguientes = tl(program)
    tokensNoNumerados = Regex.split(~r/\s+/, lineaActual, trim: true)
    tokensNumerados = Enum.flat_map(tokensNoNumerados, fn x -> [{x, linea}] end)
    linea = linea + 1
    otrostokens = sanitizerList(lineasSiguientes, linea)
    tokensNumerados ++ otrostokens
  end

  def sanitizerList(_program,_linea) do
    []
  end
end