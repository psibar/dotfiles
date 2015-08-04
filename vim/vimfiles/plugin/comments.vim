" comments.vim
"
" \ß changes lines from code to comments and vice versa.
" Works in normal mode with an optional count and in visual mode
"
" Currently setup for fortran, tex, bib, metapost, vim, maple, gnuplot,
" make, sh, awk, sed, perl, python, btm, dosbatch and dosini filetypes.
"
" There is single line comment support for the html, css, cpp and c filetypes
" but it is not pretty for blocks of comments.
"
" Maintainer: Ajit J. Thakkar (ajit AT unb.ca)
" URL: http://www.unb.ca/chem/ajit/vim.htm
" Last Change:	2003 July 21

if exists("*CommentToggle")
  finish
endif

map <Leader>ß :call CommentToggle()<cr>

function! CommentToggle()
  let lineno=line(".")
  let thisline=getline(lineno)
  if thisline =~ '^\s*$'
    unlet thisline lineno
    return
  endif
  let tailID=''
  let ft=&ft
  if ft=="fortran"
    if b:fortran_dialect=="f77"
      let commentID="C"
    else
      let commentID="!"
    endif
  elseif ft=="tex" || ft=="bib" || ft=="mp"
    let commentID="%"
  elseif ft=="vim"
    let commentID='"'
  elseif ft=="maple" || ft=="gnuplot" || ft=="sh" || ft=="make" || ft=="awk"
	\ || ft=="sed" || ft=="perl" || ft=="python"
    let commentID="#"
  elseif ft=="btm" || ft=="dosbatch"
    let commentID="rem "
  elseif ft=="dosini"
    let commentID=";"
  elseif ft=="html"
    let commentID="<!-- "
    let tailID=" -->"
  elseif ft=="css" || ft=="c" || ft=="cpp"
    let commentID="/* "
    let tailID=" */"
  else
    echohl WarningMsg | echo "Unknown filetype" | echohl None
    unlet! thisline lineno commentID ft tailID
    return
  endif
  let headpat='^\s*'.escape(commentID,'*')
  if match(thisline,headpat) > -1
    "Remove comment identifier(s)
    let thisline=substitute(thisline,headpat,"","")
    if exists("tailID")
      let thisline=substitute(thisline,escape(tailID,'*')."$","","")
    endif
  else
    "Add comment identifier(s)
    let thisline=commentID . thisline . tailID
  endif
  call setline(lineno,thisline)
  if ft != "fortran" || !exists("b:fortran_fixed_source")
    norm! ==
  endif
  unlet! thisline lineno commentID ft tailID headpat
endfunction
