" Auto-reload when vimrc changes
autocmd! bufwritepost .vimrc source ~/.vimrc

" Activates pathogen plugin - using bundle directory
execute pathogen#infect()

" Show file status in the footer
set laststatus=2
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
"              | | | | |  |   |      |  |     |    |
"              | | | | |  |   |      |  |     |    + current
"              | | | | |  |   |      |  |     |       column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax in
"              | | | | |  |   |          square brackets
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- modified flag in square brackets
"              +-- full path to file in the buffer

" Syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting = 1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:syntastic_scss_checkers = ['sass', 'scss_lint']
let g:syntastic_haml_checkers = ['haml', 'haml_lint']

if executable('ag')
  " use ag instead of grep, if available
  set grepprg=ag\ --nogroup\ --nocolor

  " use ag instead of ack, if available
  let g:ackprg = 'ag --nogroup --column'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']
endif

if executable('matcher')
  let g:path_to_matcher = '/usr/local/bin/matcher'
  let g:ctrlp_match_func = { 'match': 'GoodMatch' }

  function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)
    " Create a cache file if not yet exists
    let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
    if !( filereadable(cachefile) && a:items == readfile(cachefile) )
      call writefile(a:items, cachefile)
    endif
    if !filereadable(cachefile)
      return []
    endif

    " a:mmode is currently ignored. In the future, we should probably do
    " something about that. the matcher behaves like "full-line".
    let cmd = g:path_to_matcher.' --limit '.a:limit.' --manifest '.cachefile.' '
    if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
      let cmd = cmd.'--no-dotfiles '
    endif
    let cmd = cmd.a:str

    return split(system(cmd), "\n")
  endfunction
endif

" Vim command line working like bash (with my default aliases)
let $BASH_ENV = "~/.bash_profile"
set shellcmdflag=-O\ expand_aliases\ -c

" Open a confirm dialog if the file is changed but not saved
set confirm

" The pasted text is kept instead of the replaced part
xnoremap p "_dP"

" w!! will do the sudo if needed
cmap w!! w !sudo tee > /dev/null %

" Shows the command executed in the last line of vim
set showcmd
set cmdheight=2

" Can change the buffers without saving them
set hidden

" Turn off the backup of files
set nobackup
set nowb
set noswapfile

" Maximum quantity of undos
set undolevels=10000

" Do not break lines if the right corner is reached
set nowrap

" Set the title of the window with the file's name
set title

" Automatic indentation
set autoindent

" Searches will be case insensitive
set ignorecase

" Smart search ex: 'Daniel' == 'Daniel' BUT 'daniel' == ('daniel' || 'Daniel')
set smartcase

" Tabs with 2 spaces
set softtabstop=2
set tabstop=2
set shiftwidth=2

" Use spaces when TAB is pressed
set expandtab

" 3 spaces + TAB, turns into 4 spaces instead of 5
set shiftround

" String colors
colors ron
colorscheme desert

" Activates wildcards in the file search (command mode)
set wildmenu

" The way we list files in command mode is similar to the terminal ls
set wildmode=list:longest,full

" Some files we want to ignore on the wildcard search
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png

" Always show the cursor position in the rules
set ruler

" Activates line numbers in the bottom-left corner
set number

" Integrates the mouse with vim for all command types
set mouse=a

" Autoload the file if it is changed
set autoread

" Highlight found items during search
set hlsearch

" Search 'on the fly': matches are shown while typing
set incsearch

" Always show at least one line above/below the cursor
set scrolloff=1

" Better colors for autocomplete
highlight Pmenu ctermbg=238 gui=bold

" Dynamic autocomplete while typing
set completeopt=longest,menuone

" Dark background
set background=dark

" No compatible with VI (old version)
set nocompatible

" Activates sintax highlight plugin
syntax on

" Activates filytype plugin
filetype on
filetype plugin on
filetype indent on

" Configuração do backspace (sobre auto identação)
set backspace=eol,start,indent
set whichwrap=b,s,h,l,<,>,~,[,]

" Highlights whitespaces in the end of lines
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+\%#\@<!$/

" Deletes whitespaces in the end of lines
autocmd FileType c,cpp,java,php,ruby autocmd BufWritePre <buffer> :%s/\s\+$//e

" Fixes the order of autocomplete's TAB
let g:SuperTabMappingBackward = '<tab>'
let g:SuperTabMappingForward = '<s-tab>'

" Configures supertab plugin - autocomplete
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-p>"
let g:SuperTabCompletionContexts = ['s:ContextText']

" if has('mac') && ($TERM == 'xterm-256color' || $TERM == 'screen-256color')
"   map <Esc>OP <F1>
"   map <Esc>OQ <F2>
"   map <Esc>OR <F3>
"   map <Esc>OS <F4>
"   map <Esc>[16~ <F5>
"   map <Esc>[17~ <F6>
"   map <Esc>[18~ <F7>
"   map <Esc>[19~ <F8>
"   map <Esc>[20~ <F9>
"   map <Esc>[21~ <F10>
"   map <Esc>[23~ <F11>
"   map <Esc>[24~ <F12>
" endif

" CTRL+l cleans the screen
nnoremap <C-L> :nohl<CR><C-L>

" CTRL+k adds/removes comments
imap <silent> <C-k> <C-O>:.!perl -wlne'/^(\s*)((?:\# ?)?)(.*)/;print $2?"$1$3":"$1\# $3"'<CR>
map <silent> <C-k> :.!perl -wlne'/^(\s*)((?:\# ?)?)(.*)/;print $2?"$1$3":"$1\# $3"'<CR>
vmap <silent> <C-k> :!perl -wlne'/^(\s*)((?:\# ?)?)(.*)/;print $2?"$1$3":"$1\# $3"'<CR>

" SHIFT+[arrow] goes to visual mode selection automatically
inoremap <S-Up> <C-O>vk
nnoremap <S-Up> vk
vnoremap <S-Up> k
inoremap <S-Down> <C-O>vj
nnoremap <S-Down> vj
vnoremap <S-Down> j
inoremap <S-Right> <C-O>vl
nnoremap <S-Right> vl
vnoremap <S-Right> l
inoremap <S-Left> <C-O>vh
nnoremap <S-Left> vh
vnoremap <S-Left> h

" Mapeia o ctrl-a para abrir o arquivo do cursor em uma nova aba e jogar a aba
" no final da lista
"imap <silent> <C-A> <ESC><C-W>gf:tabm 999<CR>
"map <silent> <C-A> <C-W>gf:tabm 999<CR>
imap <silent> <C-A> <ESC><C-W>gf<CR>
map <silent> <C-A> <C-W>gf<CR>

" Mapeia o F3 para fechar o arquivo em questão (ou tab aberta)
imap <silent> <F3> <C-O>:bdelete<CR>
nmap <silent> <F3> :bdelete<CR>
vmap <silent> <F3> <ESC>:bdelete<CR>

" Mapeia o ctrl-b para explodir o buffer de arquivos em abas
imap <silent> <C-B> <C-O>:tab sball<CR>
nmap <silent> <C-B> :tab sball<CR>
vmap <silent> <C-B> <ESC>:tab sball<CR>

" Mapeia o gb e gB para andar entre os arquivos do buffer
map <silent> gb :bnext<CR>
map <silent> gB :bprev<CR>

" Mapeia o gy para pegar uma palavra do cursor e guardar no buffer
nmap gy lb"wye

" Mapeia o gw para pegar palavra do cursor e substituir pela do buffer
nmap gw lb"wPlcw<Esc>bb

" Mapeia o \' para aplicar aspas simples na palavra
nmap \' ciw'<ESC>pa'
vmap \' c'<ESC>pa'

" Mapeia o \" para aplicar aspas duplas na palavra
nmap \" ciw"<ESC>pa"
vmap \" c"<ESC>pa"


" Atalhos para erros de digitação
abbreviate conection connection
abbreviate controler controller
abbreviate methos method
abbreviate vra var
abbreviate ehco echo
abbreviate GLBOASL GLOBALS
abbreviate GLBOALS GLOBALS
abbreviate GLoBALS GLOBALS
abbreviate teh the
abbreviate strDtat strData
abbreviate accesories accessories
abbreviate accomodate accommodate
abbreviate acheive achieve
abbreviate acheiving achieving
abbreviate acn can
abbreviate acommodate accommodate
abbreviate acomodate accommodate
abbreviate acommodated accommodated
abbreviate acomodated accommodated
abbreviate adn and
abbreviate agian again
abbreviate ahppen happen
abbreviate ahve have
abbreviate ahve have
abbreviate allready already
abbreviate almsot almost
abbreviate alos also
abbreviate alot a lot
abbreviate alreayd already
abbreviate alwasy always
abbreviate amke make
abbreviate anbd and
abbreviate andthe and the
abbreviate appeares appears
abbreviate aplyed applied
abbreviate artical article
abbreviate aslo also
abbreviate audeince audience
abbreviate audiance audience
abbreviate awya away
abbreviate bakc back
abbreviate balence balance
abbreviate baout about
abbreviate bcak back
abbreviate beacuse because
abbreviate becasue because
abbreviate becomeing becoming
abbreviate becuase because
abbreviate becuse because
abbreviate befoer before
abbreviate begining beginning
abbreviate beleive believe
abbreviate bianry binary
abbreviate bianries binaries
abbreviate boxs boxes
abbreviate bve be
abbreviate changeing changing
abbreviate charachter character
abbreviate charcter character
abbreviate charcters characters
abbreviate charecter character
abbreviate charector character
abbreviate cheif chief
abbreviate circut circuit
abbreviate claer clear
abbreviate claerly clearly
abbreviate cna can
abbreviate colection collection
abbreviate comany company
abbreviate comapny company
abbreviate comittee committee
abbreviate commitee committee
abbreviate committe committee
abbreviate committy committee
abbreviate compair compare
abbreviate compleated completed
abbreviate completly completely
abbreviate comunicate communicate
abbreviate comunity community
abbreviate conected connected
abbreviate cotten cotton
abbreviate coudl could
abbreviate cpoy copy
abbreviate cxan can
abbreviate danceing dancing
abbreviate definately definitely
abbreviate develope develop
abbreviate developement development
abbreviate differant different
abbreviate differnt different
abbreviate diffrent different
abbreviate disatisfied dissatisfied
abbreviate doese does
abbreviate doign doing
abbreviate doller dollars
abbreviate donig doing
abbreviate driveing driving
abbreviate drnik drink
abbreviate ehr her
abbreviate embarass embarrass
abbreviate equippment equipment
abbreviate esle else
abbreviate excitment excitement
abbreviate exmaple example
abbreviate exmaples examples
abbreviate eyt yet
abbreviate familar familiar
abbreviate feild field
abbreviate fianlly finally
abbreviate fidn find
abbreviate firts first
abbreviate follwo follow
abbreviate follwoing following
abbreviate foriegn foreign
abbreviate fro for
abbreviate foudn found
abbreviate foward forward
abbreviate freind friend
abbreviate frmo from
abbreviate fwe few
abbreviate gerat great
abbreviate geting getting
abbreviate giveing giving
abbreviate goign going
abbreviate gonig going
abbreviate govenment government
abbreviate gruop group
abbreviate grwo grow
abbreviate haev have
abbreviate happend happened
abbreviate haveing having
abbreviate hda had
abbreviate helpfull helpful
abbreviate herat heart
abbreviate hge he
abbreviate hismelf himself
abbreviate hsa has
abbreviate hsi his
abbreviate hte the
abbreviate htere there
abbreviate htey they
abbreviate hting thing
abbreviate htink think
abbreviate htis this
abbreviate hvae have
abbreviate hvaing having
abbreviate idae idea
abbreviate idaes ideas
abbreviate ihs his
abbreviate immediatly immediately
abbreviate indecate indicate
abbreviate insted intead
abbreviate inthe in the
abbreviate iwll will
abbreviate iwth with
abbreviate jsut just
abbreviate knwo know
abbreviate knwos knows
abbreviate konw know
abbreviate konws knows
abbreviate levle level
abbreviate libary library
abbreviate librarry library
abbreviate librery library
abbreviate librarry library
abbreviate liek like
abbreviate liekd liked
abbreviate liev live
abbreviate likly likely
abbreviate littel little
abbreviate liuke like
abbreviate liveing living
abbreviate loev love
abbreviate lonly lonely
abbreviate makeing making
abbreviate mkae make
abbreviate mkaes makes
abbreviate mkaing making
abbreviate moeny money
abbreviate mroe more
abbreviate mysefl myself
abbreviate myu my
abbreviate neccessary necessary
abbreviate necesary necessary
abbreviate nkow know
abbreviate nwe new
abbreviate nwo now
abbreviate ocasion occasion
abbreviate occassion occasion
abbreviate occurence occurrence
abbreviate occurrance occurrence
abbreviate ocur occur
abbreviate oging going
abbreviate ohter other
abbreviate omre more
abbreviate onyl only
abbreviate optoin option
abbreviate optoins options
abbreviate opperation operation
abbreviate orginized organized
abbreviate otehr other
abbreviate otu out
abbreviate owrk work
abbreviate peopel people
abbreviate perhasp perhaps
abbreviate perhpas perhaps
abbreviate pleasent pleasant
abbreviate poeple people
abbreviate porblem problem
abbreviate preceed precede
abbreviate preceeded preceded
abbreviate probelm problem
abbreviate protoge protege
abbreviate puting putting
abbreviate pwoer power
abbreviate quater quarter
abbreviate questoin question
abbreviate reccomend recommend
abbreviate reccommend recommend
abbreviate receieve receive
abbreviate recieve receive
abbreviate recieved received
abbreviate recomend recommend
abbreviate reconize recognize
abbreviate recrod record
abbreviate religous religious
abbreviate rwite write
abbreviate rythm rhythm
abbreviate selectoin selection
abbreviate sentance sentence
abbreviate seperate separate
abbreviate shineing shining
abbreviate shiped shipped
abbreviate shoudl should
abbreviate similiar similar
abbreviate smae same
abbreviate smoe some
abbreviate soem some
abbreviate sohw show
abbreviate soudn sound
abbreviate soudns sounds
abbreviate statment statement
abbreviate stnad stand
abbreviate stopry story
abbreviate stoyr story
abbreviate stpo stop
abbreviate strentgh strength
abbreviate struggel struggle
abbreviate sucess success
abbreviate swiming swimming
abbreviate tahn than
abbreviate taht that
abbreviate talekd talked
abbreviate tath that
abbreviate teh the
abbreviate tehy they
abbreviate tghe the
abbreviate thansk thanks
abbreviate themselfs themselves
abbreviate theri their
abbreviate thgat that
abbreviate thge the
abbreviate thier their
abbreviate thme them
abbreviate thna than
abbreviate thne then
abbreviate thnig thing
abbreviate thnigs things
abbreviate thsi this
abbreviate thsoe those
abbreviate thta that
abbreviate tihs this
abbreviate timne time
abbreviate tje the
abbreviate tjhe the
abbreviate tkae take
abbreviate tkaes takes
abbreviate tkaing taking
abbreviate tlaking talking
abbreviate todya today
abbreviate tongiht tonight
abbreviate tonihgt tonight
abbreviate towrad toward
abbreviate tpyo typo
abbreviate truely truly
abbreviate tyhat that
abbreviate tyhe the
abbreviate useing using
abbreviate veyr very
abbreviate vrey very
abbreviate waht what
abbreviate watn want
abbreviate wehn when
abbreviate whcih which
abbreviate whic which
abbreviate whihc which
abbreviate whta what
abbreviate wief wife
abbreviate wierd weird
abbreviate wihch which
abbreviate wiht with
abbreviate windoes windows
abbreviate withe with
abbreviate wiull will
abbreviate wnat want
abbreviate wnated wanted
abbreviate wnats wants
abbreviate woh who
abbreviate wohle whole
abbreviate wokr work
abbreviate woudl would
abbreviate wriet write
abbreviate wrod word
abbreviate wroking working
abbreviate wtih with
abbreviate wya way
abbreviate yera year
abbreviate yeras years
abbreviate ytou you
abbreviate yuo you
abbreviate yuor your
abbreviate monday Monday
abbreviate tuesday Tuesday
abbreviate wednesday Wednesday
abbreviate thursday Thursday
abbreviate friday Friday
abbreviate saturday Saturday
abbreviate sunday Sunday

""""""""""""""""""""""""""""""""""""
" Help sobre alguns plugins do VIM "
""""""""""""""""""""""""""""""""""""
" cs"' = change surround = troca as aspas por plicas
" ds"  = delete surround = deleta aspas da palavra
" ysw" = yank surround   = cria aspas na palavra
