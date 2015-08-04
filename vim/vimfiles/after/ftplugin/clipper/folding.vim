function! XBaseFolds()
	let thisline = getline(v:lnum)
	if match(thisline, '^*') >= 0 
		return "="
	elseif match(thisline, '^\CMETHOD') >= 0 || match(thisline, '^\CCLASS') >= 0 || match(thisline, '^\CFUNCTION') >= 0 || match(thisline, '^\CPROCEDURE') >= 0
		return ">1"
	elseif ( match(thisline, '\<\CIF\>') >=0  || match(thisline, '\<\CFOR\> ') >=0   || match(thisline,'\CDO CASE') >=0 	)	
		return "a1"
	elseif match(thisline, '\<\CENDIF\>') >=0 || match(thisline, '\<\CNEXT\> ')>=0 || match(thisline,'\CENDCASE') >=0
		return "s1"
	else
		return "="
	endif
endfunction

setlocal foldmethod=expr
setlocal foldexpr=XBaseFolds()

function! XBaseFoldText()

"http://dhruvasagar.com/2013/03/28/vim-better-foldtext
	let line = substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart( repeat(' ', (v:foldlevel-1)*4-1) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend


	"let indent_level = indent(v:foldstart)
	"let indent = repeat(' ',indent_level)
	"let foldsize = (v:foldend - v:foldstart)
	"return indent.substitute(getline(v:foldstart),'^\s*','','').' ('.foldsize.' lines)'
endfunction

setlocal foldtext=XBaseFoldText()

