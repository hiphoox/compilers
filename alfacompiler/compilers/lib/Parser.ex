defmodule Parser do
  def parse_program(token_list) do




  if next_token == :int_keyword do
    [next_token | rest] = rest

    if next_token == :main_keyword do
      [next_token | rest] = rest

      if next_token == :open_paren do
        [next_token | rest] = rest

        if next_token == :close_paren do
          [next_token | rest] = rest


          if next_token == :open_brace do


          end

        end

      end

    end


          ##Falta agregar la parte del parse_statement
          ## Función del parse con rest

          end

        end

      end
