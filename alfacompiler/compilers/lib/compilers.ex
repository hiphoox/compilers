defmodule compilers do
  @moduledoc """
  Documentation for compilers.
  """

  def main(_args) do
    file_content = File.read!("examples/return_2.c")
    trimmed_content = String.trim(file_content)
    words = Regex.split(~r/\s+/, trimmed_content)
    
  end
end
