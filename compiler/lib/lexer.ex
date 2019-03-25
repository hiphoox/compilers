defmodule Npcc do

	def  main do
	file_content =File.read!("example.txt")
	trimmed_content= String.trim(file_content)
	words =Regex.split(~r/\s+/,trimmed_content)
	IO.inspect(words)
	tos=scan_words(words)
	IO.inspect(tos)
	end

	def scan_words(words) do
		Enum.flat_map(words, &lex_law_tokens/1)
	end


	def get_constan(program) do
		case Regex.run(~r/^\d+/, program) do
			[value] ->
			 {{:constant,String.to_integer(value)},String.trim_leading(program, value)}
		end
	end



	def lex_law_tokens(program) when program != "" do
	{token, rest}=
		case program do
		"{" <> rest ->
			{:open_brace, rest}
		"}" <> rest ->
			{:close_brace, rest}
		"(" <> rest ->
			{:open_paren, rest}
		")" <> rest ->
			{:close_paren, rest}
		";" <> rest ->
			{:semicolon, rest}
		"return" <> rest ->
			{:return__keyword, rest}
		"int" <> rest ->
			{:int_keyword, rest}
		"main" <> rest ->
			{:main_keyword, rest}

		rest-> get_constan(rest)

	end
		remaining_tokens=lex_law_tokens(rest)
		[token | remaining_tokens]


	end

	def lex_law_tokens(program) do
	[]
end



end
