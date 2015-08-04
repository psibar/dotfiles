function! CapitalizeFortKeys()

	%s/\<\(if\)\>/\U\1/g
	%s/\<\(then\)\>/\U\1/g
	%s/\<\(else\)\>/\U\1/g
	%s/\<\(use\)\>/\U\1/g
	%s/\<\(real\)\>/\U\1/g
	%s/\<\(integer\)\>/\U\1/g
	%s/\<\(character\)\>/\U\1/g
	%s/\<\(dimension\)\>/\U\1/g
	%s/\<\(write\)\>/\U\1/g
	%s/\<\(print\)\>/\U\1/g
	%s/\<\(case\)\>/\U\1/g
	%s/\<\(switch\)\>/\U\1/g
	%s/\<\(end\)\>/\U\1/g
	%s/\<\(enddo\)\>/\U\1/g
	%s/\<\(endif\)\>/\U\1/g
	%s/\<\(interface\)\>/\U\1/g
	%s/\<\(subroutine\)\>/\U\1/g
	%s/\<\(function\)\>/\U\1/g
	%s/\<\(call\)\>/\U\1/g
	%s/\<\(read\)\>/\U\1/g
	%s/\<\(program\)\>/\U\1/g
	%s/\<\(implicit\)\>/\U\1/g
	%s/\<\(none\)\>/\U\1/g
	%s/\<\(parameter\)\>/\U\1/g
	%s/\<\(intent\)\>/\U\1/g
	%s/\<\(trim\)\>/\U\1/g
	%s/(in)\>/(IN)/g
	%s/(out)\>/(OUT)/g

endfunction
