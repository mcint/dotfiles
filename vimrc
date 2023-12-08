
" 2023-11-19T11:19:51-0800
set ignorecase smartcase

" 2023-07-27T02:41:01-0700
let mapleader=","
nm <leader>w :w<cr>
nm <leader>q :q<cr>
" 2023-08-16 - $MYVIMRC :help vimrc / https://ja3k.com/blog/vimuxsh
nm <leader><leader>E :tabedit $MYVIMRC<cr>
nm <leader><leader>R :source $MYVIMRC<cr>
vm <leader><leader>d<leader> :!date +\%F<cr>
vm <leader><leader>dt<leader> :!date +\%FT\%T<cr>
vm <leader><leader>t<leader> :!date +\%T<cr>
"&& echo reloaded ~/.vimrc<cr>
nm <leader>e :edit 
nm <leader>t :tabedit 
nm <space> :set hlsearch!<cr>
nm <leader>n :set number!<cr>
nm <leader>r :set relativenumber!<cr>
nm <leader>cl<cr> :set cursorline!<cr>
nm <leader>cc<cr> :set cursorcolumn!<cr>
"nm <leader>r :set number!<cr>

" https://stackoverflow.com/a/726920/1020467 / comment
cm w!! w !sudo -S tee %
cm x!! w !sudo tee %<CR><CR>:q!<CR>

" TODO highlight on trailing whitespace

" 2023-08-15
" Temporary workaround for: https://github.com/neovim/neovim/issues/1716
if has("nvim")
  command! W w !sudo -n tee % > /dev/null || echo "Press <leader>w to authenticate and try again"
  map <leader><leader>w :new<cr>:term sudo true<cr>
else
  command! W w !sudo tee % > /dev/null
end

set tags=./tags;$HOME
" set tags+=/usr/local/share/ctags/qt4 # e.g.

if has("cscope")
    set csprg=~/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif
"" update ctags
" select_files > cscope.files
" ctags -L cscope.files
" ctags -e -L cscope.files
" cscope -ub -i cscope.files
