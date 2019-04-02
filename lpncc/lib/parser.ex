defmodule Parser do
    @moduledoc """
        <program> ::= <function>
	    <function> ::= "int" <id> "(" ")" "{" <statement> "}"
	    <statement> ::= "return" <exp> ";"
	    <exp> ::= <int>
    """

    def statement ()

    def funcion do
        if elemento == :int_keyword  do
            [elemento| tokens] = tokens
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
        if  elemento == :return_keyword do
            expresion=    
            statement(elemento)
            [elemento | tokens] = tokens  
        else
        IO.puts("Error de sintaxis sin return ")
        end
        
    end
     
    def program(tokens) do
            funcion (tokens)
        end
    
    def parseo(tokens)  do 
        if tokens != []  do
            program(tokens)
        else
            IO.puts("Error : Falta de Tokens") 
        end             
    end    
end