" ==================================
" === @nazzacode's Neovim Config ===
" ==================================

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" === Plugin Manager === "
call plug#begin()
Plug 'axvr/org.vim'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim'
Plug 'doums/darcula'
Plug 'Raimondi/delimitMate'
Plug 'neovimhaskell/haskell-vim'
Plug 'joom/latex-unicoder.vim'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'arcticicestudio/nord-vim'
Plug 'mhartington/oceanic-next'
Plug 'lingnand/pandoc-preview.vim'
Plug 'godlygeek/tabular'
Plug 'preservim/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug '907th/vim-auto-save'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
call plug#end()
" Plug 'edkolev/tmuxline.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" === Settings === "

" -- General -- "
set hidden  "allows undo after switching buffer"

" -- Indentation -- " 
set autoindent
set expandtab  "converts tabs to spaces" 
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab

" - Language Specific Indentation - "
filetype plugin indent on
autocmd FileType haskell setlocal shiftwidth=2 tabstop=2
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2

" -- Search -- "
set hlsearch  "search highlighting"
set ignorecase
set smartcase  " switch to case sensitive when uppercase used"
set incsearch  " incremental search showig partial matches" 

" -- Text Rendering -- "
syntax on 
set encoding=utf-8
set linebreak  "no wrap in middle of word"
set scrolloff=5  "display lines at eof"
set wrap  "line wrapping "
set updatetime=300

" -- User Interface -- "
set number
set relativenumber
set wildmenu  "command tab complete vertical menu"
set wildmode=longest:full,full
set title
set showcmd  "shows keyboard strokes in corner"
set fillchars+=vert:│
set noshowmode

" -- Leader key -- "
let mapleader=" "

" -- Colorscheme -- "
"colorscheme darcula

hi normal ctermbg=NONE guibg=NONE

hi clear SignColumn
hi clear LineNr 

hi VertSplit cterm=NONE ctermbg=NONE guibg=NONE
hi! link Conceal Special
hi! link FoldColumn Normal
hi!  link Folded Normal 

if (has("termguicolors"))
 set termguicolors
endif

" -- Spelling/Dictionary -- "
set spelllang=en
set spellfile=~/.config/nvim/spell/en.utf-8.add  "TODO how to add word?"

" -- Language Specific -- "

"  - Markdown - "
" Enable code highlighting in ``` 
let g:markdown_fenced_languages = ['python', 'haskell', 'javascript', 'js=javascript', 'json=javascript', 'ruby']

" -- Miscellaneous -- "
set backspace=indent,eol,start "backspace over indent, eol and start"
set confirm "when closing unsaved file"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" === Plugin Settings === "

" -- ale -- "
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
"  \   'haskell' :['hlint'],

" -- coc -- "
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" -- latex unicoder -- "
let g:unicoder_cancel_normal = 1
let g:unicoder_cancel_insert = 1
let g:unicoder_cancel_visual = 1
nnoremap <C-\> :call unicoder#start(0)<CR>
inoremap <C-\> <Esc>:call unicoder#start(1)<CR>
vnoremap <C-\> :<C-u>call unicoder#selection()<CR>

" -- pandoc-preview.vim -- "
let g:pandoc_preview_pdf_cmd = "zathura" 
nnoremap <leader>v :PandocPreview<cr>


" -- nerdcommenter -- "
let g:NerdSpaceDelims = 1


" -- nerdtree -- "
let g:NERDTreeMinimalUI=1
map <C-n> :NERDTreeToggle<CR>
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" -- Tagbar -- "
nmap <C-t> :TagbarToggle<CR> 

" -- vim-airline -- "
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
"let g:airline_powerline_fonts = 1
" -- vim-airline-theme -- "
let g:airline_theme='monochrome'

" -- vim-auto-save -- "
let g:auto_save = 1  "enable autosave on vim startup

" -- vim-pandoc -- "
nnoremap <leader>p :Pandoc<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" === My Keyboard Shortcuts === "

" escape to normal mode
inoremap jk <Esc>

" Resize splits with arrowkeys
nnoremap <Up>    :resize +1<CR>
nnoremap <Down>  :resize -1<CR>
nnoremap <Left>  :vertical resize +1<CR>
nnoremap <Right> :vertical resize -1<CR>

" Moving between splits with (C-h|j|k|l) 
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction
nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>


" -- Terminal -- "
" Open terminal below with (leader-t) 
set splitbelow
au TermOpen * setlocal nonumber norelativenumber  " no line number
"terminal mode to normal mode 
:tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on leader-t
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <leader>t :call OpenTerminal()<CR>
