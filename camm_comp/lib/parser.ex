defmodule Parser do
#Validamos que los token que recibimos sean los correctos
  def parseo ([token | resto]) do
  	if token == :int_keyword do
  		[token | resto] =  resto
			if token == :main_keyword do
				[token | resto] = resto
				if token == :open_paren do
					[token | resto] = resto
					if token == :close_paren do
						[token | resto] = resto
						if token == :open_brace do
							[token | resto] = resto
						end
					end
				end
			end
  	end
  end
end
