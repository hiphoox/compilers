defmodule Proyecto_compilador do
  @moduledoc """
  Documentacion for proyecto_compilador.
  """



  def main(args) do
    ##se pasa de argumento al main la ubicación del archivo
    IO.puts(args);
    Orquestador.manager(1, args);



  end

end
