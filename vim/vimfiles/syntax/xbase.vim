" Vim syntax file:
" Language:	Xbase++ 1.9 & xbase & Flagship
" Maintainer:	AF, based on C R Zamana <zamana@zip.net>
" Some things based on c.vim by Bram Moolenaar and pascal.vim by Mario Eusebio
" Last Change:	2014 Dec 10 by AF

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Exceptions for my "Very Own" (TM) user variables naming style.
" If you don't like this, comment it
syn match  xbaseUserVariable	"\<[a,b,c,d,l,n,o,u,x][A-Z][A-Za-z0-9_]*\>"
syn match  xbaseUserVariable	"\<[a-z]\>"

" xbase is case insensitive ( see "exception" above )
syn case ignore

" xbase keywords ( in no particular order )
syn keyword xbaseStatement	ACCEPT APPEND BLANK FROM AVERAGE CALL CANCEL
syn keyword xbaseStatement	CLEAR ALL GETS MEMORY TYPEAHEAD CLOSE
syn keyword xbaseStatement	COMMIT CONTINUE SHARED NEW PICT
syn keyword xbaseStatement	COPY FILE STRUCTURE STRU EXTE TO COUNT
syn keyword xbaseStatement	CREATE FROM NIL
syn keyword xbaseStatement	DELETE FILE DIR DISPLAY EJECT ERASE FIND GO
syn keyword xbaseStatement	INDEX INPUT VALID WHEN
syn keyword xbaseStatement	JOIN KEYBOARD LABEL FORM LIST LOCATE MENU TO
syn keyword xbaseStatement	NOTE PACK QUIT READ
syn keyword xbaseStatement	RECALL REINDEX RELEASE RENAME REPLACE REPORT
syn keyword xbaseStatement	RETURN FORM RESTORE
syn keyword xbaseStatement	RUN SAVE SEEK SELECT
syn keyword xbaseStatement	SKIP SORT STORE SUM TEXT TOTAL TYPE UNLOCK
syn keyword xbaseStatement	UPDATE USE WAIT ZAP
syn keyword xbaseStatement	BEGIN SEQUENCE RECOVER ENDSEQUENCE
syn keyword xbaseStatement	SET ALTERNATE BELL CENTURY COLOR CONFIRM CONSOLE
syn keyword xbaseStatement	CURSOR DATE DECIMALS DEFAULT DELETED DELIMITERS
syn keyword xbaseStatement	DEVICE EPOCH ESCAPE EXACT EXCLUSIVE FILTER FIXED
syn keyword xbaseStatement	FORMAT FUNCTION INTENSITY KEY MARGIN MESSAGE
syn keyword xbaseStatement	ORDER PATH PRINTER PROCEDURE RELATION SCOREBOARD
syn keyword xbaseStatement	SOFTSEEK TYPEAHEAD UNIQUE WRAP
syn keyword xbaseStatement	BOX CLEAR GET PROMPT SAY ? ??
syn keyword xbaseStatement	DELETE TAG GO RTLINKCMD TMP DBLOCKINFO
syn keyword xbaseStatement	DBEVALINFO DBFIELDINFO DBFILTERINFO DBFUNCTABLE
syn keyword xbaseStatement	DBOPENINFO DBORDERCONDINFO DBORDERCREATEINF
syn keyword xbaseStatement	DBORDERINFO DBRELINFO DBSCOPEINFO DBSORTINFO
syn keyword xbaseStatement	DBSORTITEM DBTRANSINFO DBTRANSITEM WORKAREA

" Conditionals
syn keyword xbaseConditional	CASE OTHERWISE ENDCASE
syn keyword xbaseConditional	IF ELSE ELSEIF ENDIF IIF IFDEF IFNDEF

" Loops
syn keyword xbaseRepeat	DO WHILE ENDDO
syn keyword xbaseRepeat	FOR TO NEXT STEP

" Visibility
syn keyword xbaseStorageClass	ANNOUNCE STATIC
syn keyword xbaseStorageClass DECLARE EXTERNAL LOCAL MEMVAR PARAMETERS
syn keyword xbaseStorageClass PRIVATE PROCEDURE PUBLIC REQUEST STATIC
syn keyword xbaseStorageClass FIELD FUNCTION VAR CLASS ENDCLASS EXPORTED PROTECTED 
syn keyword xbaseStorageClass EXIT PROCEDURE INIT PROCEDURE METHOD self SELF

" Operators
syn match   xbaseOperator	"$\|%\|&\|+\|-\|->\|!"
syn match   xbaseOperator	"\.AND\.\|\.NOT\.\|\.OR\."
syn match   xbaseOperator	":=\|<\|<=\|<>\|!=\|#\|=\|==\|>\|>=\|@"
syn match   xbaseOperator     "*"

" Numbers
syn match   xbaseNumber	"\<\d\+\(u\=l\=\|lu\|f\)\>"

" Includes
syn region xbaseIncluded	contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match  xbaseIncluded	contained "<[^>]*>"
syn match  xbaseInclude	"^\s*#\s*include\>\s*["<]" contains=xbaseIncluded

" String and Character constants
syn region xbaseString	start=+"+ end=+"+
syn region xbaseString	start=+'+ end=+'+

" Delimiters
syn match  xbaseDelimiters	"[()]\|[\[\]]\|[{}]\|[||]"

" Special
syn match xbaseLineContinuation	";"

" This is from Bram Moolenaar:
if exists("c_comment_strings")
  " A comment can contain cString, cCharacter and cNumber.
  " But a "*/" inside a cString in a xbaseComment DOES end the comment!
  " So we need to use a special type of cString: xbaseCommentString, which
  " also ends on "*/", and sees a "*" at the start of the line as comment
  " again. Unfortunately this doesn't very well work for // type of comments :-(
  syntax match xbaseCommentSkip	contained "^\s*\*\($\|\s\+\)"
  syntax region xbaseCommentString	contained start=+"+ skip=+\\\\\|\\"+ end=+"+ end=+\*/+me=s-1 contains=xbaseCommentSkip
  syntax region xbaseComment2String	contained start=+"+ skip=+\\\\\|\\"+ end=+"+ end="$"
  syntax region xbaseComment		start="/\*" end="\*/" contains=xbaseCommentString,xbaseCharacter,xbaseNumber,xbaseString
  syntax match  xbaseComment		"//.*" contains=xbaseComment2String,xbaseCharacter,xbaseNumber
else
  syn region xbaseComment		start="/\*" end="\*/"
  syn match xbaseComment		"//.*"
endif
syntax match xbaseCommentError	"\*/"

" Lines beggining with an "*" are comments too
syntax match xbaseComment		"^\*.*"


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_xbase_syntax_inits")
  if version < 508
    let did_xbase_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink xbaseConditional		Conditional
  HiLink xbaseRepeat			Repeat
  HiLink xbaseNumber			Number
  HiLink xbaseInclude		Include
  HiLink xbaseComment		Comment
  HiLink xbaseOperator		Operator
  HiLink xbaseStorageClass		StorageClass
  HiLink xbaseStatement		Statement
  HiLink xbaseString			String
  HiLink xbaseFunction		Function
  HiLink xbaseLineContinuation	Special
  HiLink xbaseDelimiters		Delimiter
  HiLink xbaseUserVariable		Identifier

  delcommand HiLink
endif

let b:current_syntax = "xbase"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim: ts=8
