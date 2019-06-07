defmodule Parser do
  def parse_tokens(token_list, flag) do
    output = parse_program(token_list)
    #si output fue una tupla error, regrésala. Sino parsea bandera y devuelve arbol
    if elem(output, 0) == :error , do: output, else: parsing_flag(output, flag)
  end

  def parse_program(tokens) do
    [tokens, func_node] = parse_function(tokens)
    case tokens do
      {:error, _} -> tokens
      _-> {:program, "program", func_node, {}}
    end
  end

  def parse_function(tokens) do
    #si en algun momento del parseo, tokens = {:error, ...} propagalo
    #Se ignoran algunos valores y átomos. No son de interés para construir el árbol, solo para verificar.
    {_atom, _value, tokens} = parse(tokens, :int_Keyword)
    {_atom, _value, tokens} = parse(tokens, :main_Keyword)
    {_atom, _value, tokens} = parse(tokens, :open_paren)
    {_atom, _value, tokens} = parse(tokens, :close_paren)
    {_atom, _value, tokens} = parse(tokens, :open_brace)
    #Si tokens = {:error,..} sigue propagandolo
    [tokens, state_node] = parse_statement(tokens)
    #Aquí sigue llegando la tupla de error en tokens, sigue pasandola...
    {_atom, _value, tokens} = parse(tokens, :close_brace)
    #Si tokens trae error, devuelve ese mismo error sin crear un nodo de árbol
    case tokens do
      {:error, _} -> [tokens, ""]
      #De lo contrario, devuelve lista de tokens y el nodo a construir.
      _ -> [tokens, {:function, "main", state_node, {}}]
    end
  end

  def parse_statement(tokens) do
    case tokens do #case 1
      {:error, _} -> [tokens, ""]
      _-> {atom, _value, tokens} = parse(tokens, :return_Keyword)

      #Parseando expresión completa
      case tokens do #case 2
        {:error, _} -> [tokens, ""]
        _-> [tokens, exp_node] = parse_expression(tokens)
            #Finalizando, revisa si existe el ;
            {_atom, _value, tokens} = parse(tokens, :semicolon)
            case tokens do #case 3
            #Si tokens trae error, devuelve ese mismo error sin crear un nodo de árbol
            {:error, _} -> [tokens, ""]
            #De lo contrario, devuelve lista de tokens y el nodo a construir.
            _ -> [tokens, {atom, "return", exp_node, {}}]
          end #end case 3
      end #end case 2
    end #end case 1
  end

  def parse_expression(tokens) do
    [tokens, node_term] = parse_term(tokens, ""); #term -> factor (constant, unop, binop)
    #[head|tail] = tokens
    #Control de errores, ver si viene uno de ellos o una suma/resta después de un factor
    case tokens do
    {:error, _} -> [tokens, ""]
    _-> if List.first(tokens) == :negation_Keyword or List.first(tokens) == :addition_Keyword do
          next_term_exp(tokens, node_term)
        else
          [tokens, node_term]; #Sin operación de suma o resta
        end
    end
  end

  def next_term_exp(tokens, node_term) do
    #Extrae el operador binario
    [tokens, operator] = parse_operation(tokens);

    #Cambiar operador unario de negación a resta binaria
    if operator == :negation_Keyword do
       operator = :minus_Keyword
       #node_term es nodo hoja operando 1
       #next_term es nodo hoja operando 2, extraer con la siguiente función.
       [tokens, next_term] = parse_term(tokens, operator)

       #¿Faltó el segundo operando?
       case tokens do #case 1
         {:error, _} -> [tokens, ""]
          _ ->
          #Construccion del nodo con resta como operando.
          [tokens, node_term] = parse_bin_op(tokens, operator, node_term, next_term);
          [head|_] = tokens
          #recursividad
          #¿Hay más sumas o restas? Llama a esta misma función para parsear operadores y operandos.
          case tokens do #case 2
              {:error, _} -> [tokens, ""]
              _ -> if head == :negation_Keyword or head ==:addition_Keyword do
                     next_term_exp(tokens, node_term)
                   else
                     [tokens, node_term]; #no hubo operacion de suma ni resta
                   end #end if
          end #end case 2
       end #end case 1
    else
          #node_term es nodo hoja 1
          #next_termn es nodo hoja 2
          [tokens, next_term] = parse_term(tokens, operator)
          #¿Faltó el segundo operando?
          case tokens do #case 1
            {:error, _} -> [tokens, ""]
            _->  #Construccion del nodo con resta como operando.
            [tokens, node_term] = parse_bin_op(tokens, operator, node_term, next_term);
            [head|_] = tokens
            #recursividad
            #¿Hay más sumas o restas? Llama a esta misma función para parsear operadores y operandos.
            case tokens do #case 2
              {:error, _} -> [tokens, ""]
               _ -> if head == :negation_Keyword or head ==:addition_Keyword do
                      next_term_exp(tokens, node_term)
                    else
                      [tokens, node_term]; #no hubo operacion de suma ni resta
                    end #end if
              end #end case 2
            end #end case 1
     end
  end #end


  #OP BIN, creación del nodo con operador y sus dos operandos
  def parse_bin_op(tokens, operator, node_term, next_term) do
    [tokens, {operator, diccionario(operator), node_term, next_term}]
  end

  #***************************PARSE TERM****************
  def parse_term(tokens, last_op) do
    #envia el operador parseado con anterioridad por si ocurre un error
    [tokens, node_factor] = parse_factor(tokens, last_op); #oks
    case tokens do
      {:error, _} -> [tokens, ""]
      _ -> if List.first(tokens) == :multiplication_Keyword or List.first(tokens) == :division_Keyword do
              next_factor_term(tokens, node_factor)
           else #sino hay mmultiplicacion o division
              [tokens, node_factor]; #no hubo operacion de suma ni resta
          end
    end
  end

  def next_factor_term(tokens, node_factor)  do
    [tokens, operator] = parse_operation(tokens); #extrae el operador 1
    [tokens, next_factor] = parse_factor(tokens, operator) #extrae el operador 2

    # construccion del nodo con suma o resta
    [tokens, node_factor] = parse_bin_op(tokens, operator, node_factor, next_factor);
    #recursividad
    case tokens do
      {:error, _} -> [tokens, ""]
      _ -> if List.first(tokens) == :multiplication_Keyword or List.first(tokens) ==:division_Keyword do
              next_factor_term(tokens, node_factor)
           else #sino hay mmultiplicacion o division, continua
              [tokens, node_factor];
           end
    end
  end


  def parse_factor(tokens, last_op) do
    #Parsea tokens dentro de los parentesis, revisar si tiene paréntesis de cierre
    if List.first(tokens) == :open_paren do
      tokens=Enum.drop(tokens, 1);
      [tokens, node_exp] = parse_expression(tokens);

      #si la expresion trae tupla de error, regresala
      case tokens do
        {:error, _} -> [tokens, ""]
        _ ->   if List.first(tokens) != :close_paren do
            [{:error, "Se esperaba " <> diccionario(:close_paren) <> "después de la expresión y se encontró " <> diccionario(List.first(tokens))}, ""]
          else
            tokens=Enum.drop(tokens, 1);
            [tokens, node_exp];
          end
      end

    #Parseando con operador unario
    else if List.first(tokens) == :negation_Keyword or List.first(tokens) == :bitewise_Keyword or List.first(tokens) == :logicalNeg_Keyword  do
        [tokens, operator] = parse_operation(tokens);
        [tokens, factor] = parse_factor(tokens, "")
        #Operador unario con un operando solamente
        parse_unary_op(tokens, operator, factor)
      else
        #Constante unicamente, parsear y devolver
        #Control de errores si no fue ninguno de los casos anteriores
        case List.first(tokens) do
          {:constant, _} -> parse_constant(tokens, :constant)
          _ -> if (List.first(tokens)) == :division_Keyword or (List.first(tokens)) == :addition_Keyword or (List.first(tokens)) == :multiplication_Keyword  do
                 [{:error, "Error de sintaxis: Falta el primer operando antes de " <> diccionario(List.first(tokens)) <> "."}, ""]
               else
                 if last_op == :addition_Keyword or last_op == :minus_Keyword or last_op == :multiplication_Keyword or last_op == :division_Keyword do
                   [{:error, "Error de sintaxis: Falta el segundo operando después de " <> diccionario(last_op) <> "."}, ""]
                 else
                   [{:error, "Error de sintaxis: Se esperaba una constante u operador y se encontró " <> diccionario(List.first(tokens)) <> "."}, ""]
                 end
               end
        end
    end
  end
  end


  #PARSEO OPERADOR UNARIO

  def parse_unary_op(tokens, operator, factor) do
    [tokens, {operator, diccionario(operator), factor, {}}]
  end

  def parse_operation(tokens) do
      operator = List.first(tokens); #guardo el operador
      tokens = Enum.drop(tokens, 1) #extraccion del operador
      [tokens, operator];
      end

#funcion que extrae y parsea el operador unario
  def parse_unary_ops(token, atom) do
    case token do
      {:error, _} -> {"", "", token}; #envia null porque solo te interesa propagar tokens
      _ -> if List.first(token) == atom do
              remain=Enum.drop(token, 1) #extraer el elemento de la lista de tokens y borrarlo
              [token, inner_exp] = parse_expression(remain)#RECURSIVIDAD, inner_exp contiene los elementos restantes de de la expresión, llama a parser_exp para volver a parsear hasta que terminemos de evaluar todos los elementos
              [token, {atom, diccionario(atom), inner_exp,{}}]
           else
              [{:error, ""}, ""]
          end
    end
  end


  def parse_constant(token, atom) do
    #¿Token trae tupla error en vez de la lista? devuelvela tal como está.
    case token do
      {:error, _} -> {"", "", token}; #envia null porque solo te interesa propagar tokens
      _ -> if elem(List.first(token), 0) == atom do
              [Enum.drop(token, 1), {elem(List.first(token),0), elem(List.first(token),1),{},{}}]
           else
              #{"", "", {:error, "Error de sintáxis. Constante inválida."}}
          end
    end
  end

  def parse(token, atom) do
    #Si el token entrante es un error, devuelvelo tal como está
    case token do
      {:error, _} -> {"", "", token};
      _ -> if List.first(token) == atom do
              {atom, "", Enum.drop(token, 1)}
           else
              {"", "", {:error, "Error de sintáxis. Se esperaba "<> diccionario(atom) <>" y se encontró: " <> diccionario(List.first(token))}}
           end
    end
  end

  #Muestra en pantalla el árbol. Finaliza ejecución al devolver la tupla :only_ast
  def parsing_flag(ast, :show_ast) do
    IO.inspect(ast)
    {:only_ast, ast}
  end

  #Sólo devuelve el árbol al orquestador para continuar
  def parsing_flag(ast, _) do
    {:ok, ast}
  end

  #Diccionario utilizado para convertir los Keyword a caractéres.
  def diccionario(atom) do
      case atom do
          :int_Keyword->"int"
          :main_Keyword->"main"
          :open_paren->"("
          :close_paren->")"
          :open_brace->"{"
          :close_brace->"}"
          :return_Keyword->"return"
          :semicolon->";"
          :logicalNeg_Keyword->"!"
          :negation_Keyword->"-"
          :minus_Keyword -> "-"
          :bitewise_Keyword -> "~"
          :addition_Keyword -> "+"
          :division_Keyword -> "/"
          :multiplication_Keyword -> "*"
          _ -> "(vacío)"
      end
  end
end
