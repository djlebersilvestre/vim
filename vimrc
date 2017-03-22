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

" Usar espaços quando teclar TAB
set expandtab

" Se estiver com 3 espaços e teclar tab, vai para 4 ao invés de 5
set shiftround

" Aplica cores mais fortes
colors ron
colorscheme desert

" Permite wildcards na busca de arquivos no modo de comando (modo recursivo)
set wildmenu

" O ls do console de comandos é igual ao ls da linha de comando do terminal
set wildmode=list:longest,full

" Arquivos que devem ser ignorados na pesquisa com wildcards
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png

" Sempre deve mostrar a posição do cursor
set ruler

" Ativa a numeração da linha no lado esquedo da tela
set number

" Ativa o mouse em todos os modos para se integrar com o vim (para copy e
" paste com middle button mudar para 'r')
set mouse=a

" Sempre que um arquivo mudar (por algum intervenção externa), o vim recarrega ele automaticamente
set autoread

" Destaca os itens pesquisados no texto inteiro
set hlsearch

" A busca opera já enquanto estiver digitando, ou seja, incremental
set incsearch

" Always show at least one line above/below the cursor
set scrolloff=1

" Melhora as cores do menu de auto-complete
highlight Pmenu ctermbg=238 gui=bold

" Desliga a identificação de comentários automática
"set fo-=c fo-=o fo-=r

" Deixa o drop-down do auto-complete dinâmico na digitação da palavra
set completeopt=longest,menuone

" Força o background para preto
set background=dark

" Desabilita completamente a compatibilidade com o VI
set nocompatible

" Ativa o plugin de destaque de sintaxe
syntax on

" Ativa o plugin de identificação de arquivos
filetype on
filetype plugin on
filetype indent on

" Configuração do backspace (sobre auto identação)
set backspace=eol,start,indent
set whichwrap=b,s,h,l,<,>,~,[,]

" Destaca espaços em branco (com a cor azul) no final de linhas
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+\%#\@<!$/

" Deleta espaços em branco no final das linhas
autocmd FileType c,cpp,java,php,ruby autocmd BufWritePre <buffer> :%s/\s\+$//e

" Acerta a ordem dos tabs de auto-complete (plugin SuperTab)
let g:SuperTabMappingBackward = '<tab>'
let g:SuperTabMappingForward = '<s-tab>'

" Configura para identificação automática do contexto do auto-complete (plugin
" SuperTab)
let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabContextDefaultCompletionType = "<c-p>"
"let g:SuperTabCompletionContexts = ['s:ContextText']

" Mapeia o ctrl-l para limpar a tela até a próxima pesquisa
nnoremap <C-L> :nohl<CR><C-L>

" Mapeia o ctrl-k para comentar / descomentar uma linha com #
imap <silent> <C-k> <C-O>:.!perl -wlne'/^(\s*)((?:\# ?)?)(.*)/;print $2?"$1$3":"$1\# $3"'<CR>
map <silent> <C-k> :.!perl -wlne'/^(\s*)((?:\# ?)?)(.*)/;print $2?"$1$3":"$1\# $3"'<CR>
vmap <silent> <C-k> :!perl -wlne'/^(\s*)((?:\# ?)?)(.*)/;print $2?"$1$3":"$1\# $3"'<CR>

" Mapeamento do shift-seta para seleção de textos em modo visual conforme editores padrão
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

" Mapeia o ctrl-f6 para pular as abas (semelhante ao eclipse)
imap <silent> <C-F6> <ESC>gt
nmap <silent> <C-F6> gt
vmap <silent> <C-F6> gt
imap <silent> <C-S-F6> <ESC>gT
nmap <silent> <C-S-F6> gT
vmap <silent> <C-S-F6> gt

" Mapeia o ctrl-a para abrir o arquivo do cursor em uma nova aba e jogar a aba
" no final da lista
"imap <silent> <C-A> <ESC><C-W>gf:tabm 999<CR>
"map <silent> <C-A> <C-W>gf:tabm 999<CR>
imap <silent> <C-A> <ESC><C-W>gf<CR>
map <silent> <C-A> <C-W>gf<CR>

" Mapeia o F4 para fechar o arquivo em questão (ou tab aberta)
imap <silent> <F4> <C-O>:bdelete<CR>
nmap <silent> <F4> :bdelete<CR>
vmap <silent> <F4> <ESC>:bdelete<CR>

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
