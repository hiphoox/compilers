defmodule Parser do
    @moduledoc """
        <program> ::= <function>
	    <function> ::= "int" <id> "(" ")" "{" <statement> "}"
	    <statement> ::= "return" <exp> ";"
	    <exp> ::= <int>
    """

    def parseo(tokens)  do 
        if tokens != []  do
            program(tokens)
        else
            IO.puts("Error : Falta de Tokens") 
        end             
    end
    
    def program(tokens) do
        funcion (tokens)
    end

    def funcion([elemento | tokens]) do
        if elemento == :int_keyword  do
            [elemento | tokens] = tokens
            IO.puts("INT")
        else
         IO.puts("Error de sintaxis")
             end 
        if elemento == :main_keyword do
            [elemento | tokens] = tokens 
             IO.puts("Main")
        else
        IO.puts("Erro no main")
        end
        if elemento == :open_paren do
            [elemento | tokens] = tokens 
        else
        IO.puts("Error falta parentesis '(' ")
        end
        if  elemento == :close_paren do
            [elemento | tokens] = tokens  
        else
        IO.puts("Error falta parentesis ')' ")
        end
        if  elemento == :open_brace do
            statements = statement([elemento | tokens]) 
        else
        IO.puts("Error de sintaxis sin return ")
        end
        {statement_node, [elemento | tokens]} ->
            if elemento == :close_brace do
              {%AST{node_name: :function, valor: :main, left_node: statement_node}, rest}
            else
              {{:error, "Error, close brace missed"}, rest}
            end
        
    end

    def statement ([elemento | tokens]) do
        if elemento == :return_keyword do
            expresion = expression(tokens)
        end        
    end

    def expression([elemento | tokens]) do
        if elemento do
            {:constant, valor} -> {%AST{constante: :constant, valor: valor}, tokens}
            _ -> IO.puts("Error: Constante no encontrada")
        end
    end
end