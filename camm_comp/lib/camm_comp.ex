defmodule CammComp do
  @moduledoc """
  Documentation for Compilador
  """
  def main(_args) do
    file_content = File.read!("examples/e1.c")
    trimmed_content = String.trim(file_content)
    words = Regex.split(~r/\s+/,trimmed_content)
    IO.inspect(words)
  end
end
