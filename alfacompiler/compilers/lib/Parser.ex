defmodule Parser do
  def parse_program(token_list) do
    function = parse_function(token_list)
