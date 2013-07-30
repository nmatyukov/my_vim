" по умолчанию - латинская раскладка
set iminsert=0
" по умолчанию - латинская раскладка при поиске
set imsearch=0
" игнорировать регистр при поиске
set ic
" подсвечивать поиск
set hls
" использовать инкрементальный поиск
set is

" нумерация строк
set nu!

" ширина текста 
set textwidth=70

" минимальная высота окна пусть будет 0 (по умолчанию - 1)
" set winminheight=0

" размеры окна
" if has("gui_running")
"   " GUI is running or is about to start.
"   " Maximize gvim window.
"   set lines=50 columns=170
" else
"   " This is console Vim.
"   if exists("+lines")
"     set lines=50
"   endif
"   if exists("+columns")
"     set columns=100
"   endif
" endif

" всегда делать активное окно максимального размера
"set noequalalways
"set winheight=9999

" настраиваю для работы с русскими словами (чтобы w, b, * понимали
" русские слова)
set iskeyword=@,48-57,_,192-255

" Сделать так, чтобы русские буквы можно было вводить, когда системная раскладка находится в режиме ввода латинских символов.
set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

" задать размер табуляции в четыре пробела
set ts=4

" отображение выполняемой команды
set showcmd 

" перенос по словам, а не по буквам
set linebreak
set dy=lastline


" По <F4> открывается новая вкладка (tab) и выводится список каталогов и файлов текущего каталога. Клавишами управления курсором можно выбрать каталог или файл. Нажатие <Enter> на каталог отобразит его содержимое в том же режиме (можно путешествовать по каталогам), а нажатие <Enter> на файле - откроет его в этой же вкладке. Работает быстрый поиск-перемещение по "/".

imap <F4> <Esc>:browse tabnew<CR> 
map <F4> <Esc>:browse tabnew<CR>

"Пользовательское меню. По <F9> позволяет приостановить работу Vim и вызвать соответствующие программы:

set wildmenu
set wcm=<Tab>
menu Exec.GForth  :!gforth % <CR>
menu Exec.Perl    :!perl % <CR>
menu Exec.Python  :!python % <CR>
menu Exec.Ruby    :!ruby % <CR>
menu Exec.bash      :!/bin/bash<CR>
menu Exec.xterm     :!xterm<CR>
menu Exec.mc        :!mc<CR>
menu Exec.xterm_mc  :!xterm -e mc<CR>
map <F9> :emenu Exec.<Tab>

"Позволяет по <Tab>, более привычному некоторым пользователям, вызывать авто-дополнение для текущего активного синтаксиса:

function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
 endfunction
 inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
 inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>

" execute shell in new window

" google translate sudo gem install google-translate
map <F4> :exe ":AsyncShell python /home/quant/.vim/plugin/g_trans.py ".expand("<cword>")<CR>

"vundle
set nocompatible
filetype off " обязательно!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
filetype plugin indent on " обязательно!
Bundle 'vundle'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/nerdtree' 
Bundle 'kien/ctrlp.vim'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
Bundle "garbas/vim-snipmate"
Bundle "akitaonrails/snipmate-snippets"

Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'mileszs/ack.vim'
Bundle 'lucapette/vim-ruby-doc'
Bundle 'mattn/zencoding-vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/syntastic'
Bundle 'altercation/vim-colors-solarized'
Bundle 'endel/vim-github-colorscheme'
Bundle 'ervandew/supertab'
Bundle 'vim-scripts/DfrankUtil'
Bundle 'jcf/vim-latex'
Bundle 'kchmck/vim-coffee-script'
" Bundle 'coot/atp_vim'

" NERDTree settings
nmap \p :NERDTree<cr>
let NERDTreeIgnore=['\.swp$']

nnoremap <Esc>A <up>
nnoremap <Esc>B <down>
nnoremap <Esc>C <right>
nnoremap <Esc>D <left>
inoremap <Esc>A <up>
inoremap <Esc>B <down>
inoremap <Esc>C <right>
inoremap <Esc>D <left>

if has("balloon_eval")
  set noballooneval
endif


" Tlist_Use_Right_Window By default, the vertically split taglist 
" window will appear on the left hand side. If you prefer to open 
" the window on the right hand side.

let Tlist_Use_Right_Window = 1

" zencoding Leader
let g:user_zen_leader_key = '<c-y>'
nnoremap <silent> <F8> :TlistToggle<CR>

" mozrepl with vim
autocmd BufWriteCmd *.html,*.css,*.gtpl :call Refresh_firefox()
function! Refresh_firefox()
  if &modified
    write
    silent !echo  'vimYo = content.window.pageYOffset;
          \ vimXo = content.window.pageXOffset;
          \ BrowserReload();
          \ content.window.scrollTo(vimXo,vimYo);
          \ repl.quit();'  |
          \ nc -w 1 localhost 4242 2>&1 > /dev/null
  endif
endfunction

command! -nargs=1 Repl silent !echo
      \ "repl.home();
      \ content.location.href = '<args>';
      \ repl.enter(content);
      \ repl.quit();" |
      \ nc localhost 4242

nmap <leader>mh :Repl http://
" mnemonic is MozRepl Http
nmap <silent> <leader>ml :Repl file:///%:p<CR>
" mnemonic is MozRepl Local
nmap <silent> <leader>md :Repl http://localhost/
" mnemonic is MozRepl Development

" цветовая схема: измененный default
" colo default
syntax enable
set background=light
colo github 

" hamlc == haml 
au BufRead,BufNewFile *.hamlc set ft=haml
