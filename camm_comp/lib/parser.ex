defmodule Parser do
	@type exp ::  integer

  @type keywords :: {:intkeyword, charlist}
									|{:returnkeyword, charlist}
									|{:mainkeyword, charlist}

	@type caracter :: {:open_brance, char}
									| {:close_brance, char}
									| {:open_parenthesis, char}
									| {:close_parenthesis, char}
									| {:semicolon, char}


  @type statement :: keywords , exp , caracter

  @type functions :: keywords, keywords, caracter,
										caracter,caracter ,statement, caracter

  @type program :: function

	
end
