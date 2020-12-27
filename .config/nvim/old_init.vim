" ============================================================================ 
" ===                           NATHANS CONFIG.                            === 
" ============================================================================ 

" === Package manager === "
execute pathogen#infect()
execute pathogen#helptags()

" === Settings === "
filetype plugin indent on
syntax on
set hidden "allows undo after switching buffer"
set spelllang=en 
set spellfile=~/.config/nvim/spell/en.utf-8.add

" -- Indentation Options -- "
set autoindent
set expandtab "converts tabs to spaces" 
filetype plugin indent on 
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab "inserts tab-stop number of spaces when pressed"

" -- Language specific indentation -- "
autocmd FileType haskell setlocal shiftwidth=2 tabstop=2

" === Search Options === "
set hlsearch "search highlighting"
set ignorecase
set smartcase "switch to case sensitive when uppercase used"
set incsearch "incremental search showing partial matches"

" === Text Rendering Options === "
set encoding=utf-8
set linebreak "no wrap in middle of word"
set scrolloff=5 "number of lines to keep below the cursor"
set wrap "line wrapping"
set scrolloff=10 "display lines after eof"

" === User Interface option === "
set number
"set relativenumber "relative to line number"
"set laststatus=2 "always display the status bar"
set ruler "show cursor"
set wildmenu "Display command lines tab complete as options menu"
set wildmode=longest:full,full
set cursorline "highlight line under cursor"
set mouse=a "mouse scrolling and resizing"
set title "set window title"
set showcmd "shows recent keyboard strokes in corner"
set colorcolumn=80
highlight ColorColumn ctermbg=darkgrey

" === Colourscheme Options === "
"colorscheme lucius
"LuciusDark
if (has("termguicolors"))
 set termguicolors
endif
colorscheme OceanicNext
let g:airline_theme='oceanicnext'

" === Miscellaneous Options === "
set backspace=indent,eol,start "backspace over indent, eol and start"
set confirm "when closing unsaved file"
set backupdir=~/.cache/nvim "backup files"
set dir=~/.cache/nvim "swap files"
set tags=tags

" === Nathans Shortcuts === "
inoremap jk <Esc>

" Disable arrow movement, resize splits instead.
nnoremap <Up>    :resize +1<CR>
nnoremap <Down>  :resize -1<CR>
nnoremap <Left>  :vertical resize +1<CR>
nnoremap <Right> :vertical resize -1<CR>

" moving between splits 
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


" === Terminal === "
set splitbelow
" no line number
au TermOpen * setlocal nonumber norelativenumber
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

" Markdown preview
noremap <silent> <leader>om :call OpenMarkdownPreview()<cr>

function! OpenMarkdownPreview() abort
    if exists('s:markdown_job_id') && s:markdown_job_id > 0
        call jobstop(s:markdown_job_id)
        unlet s:markdown_job_id
    endif
    let available_port = system(
        \ "lsof -s tcp:listen -i :40500-40800 | awk -F ' *|:' '{ print $10 }' | sort -n | tail -n1"
        \ ) + 1
    if available_port == 1 | let available_port = 40500 | endif
    let s:markdown_job_id = jobstart('grip ' . shellescape(expand('%:p')) . ' :' . available_port)
    if s:markdown_job_id <= 0 | return | endif
    call system('google-chrome http://localhost:' . available_port)
endfunction

" === Plugin Settings === "
" -- NERDTree -- "
let g:NERDTreeMinimalUI=1
map <C-n> :NERDTreeToggle<CR>
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" -- NERD Commenter -- "
let g:NerdSpaceDelims=1

" -- Tagbar -- "
nmap <C-t> :TagbarToggle<CR> 

" -- Syntastic (recomended) -- "
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" -- Vim airline -- "
" Vim airline theme
"let g:airline_theme='airline-minimal'

" Extensions
let g:airline_extensions = [ 'coc']

" -- Emmet -- "
"let g:user_emmet_leader_key='<C-Z>'

" -- Coc  --- "
"" haskell lsp
set rtp+=~/.nvim/pack/pathogen/start/LanguageClient-neovim
let g:LanguageClient_serverCommands = { 'haskell': ['hie-wrapper', '--lsp'] }

" -- Coc (recomended) -- "
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
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
  else
    call CocAction('doHover')
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

" Remap keys for applying codeAction to the current line.
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

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

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

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>\
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

