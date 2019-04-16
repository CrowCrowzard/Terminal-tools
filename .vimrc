"autocmd BufNewFile *.cpp 0r /Users/hedgehog/RiPPro/Template/contest.cpp
"autocmd BufNewFile *.sh 0r /Users/hedgehog/workspace/template/temp.sh
"autocmd BufNewFile *.cpp 0r /Users/hedgehog/RiPPro/Template/temp.cpp
"autocmd BufNewFile *.rb 0r /Users/hedgehog/workspace/template/temp.rb
"autocmd BufNewFile *.py 0r /Users/hedgehog/workspace/template/temp.py

" Vi互換モードをオフ（Vimの拡張機能を有効）
set nocompatible
" ファイル名と内容によってファイルタイプを判別し、ファイルタイププラグインを有効にする
filetype indent plugin on
" 色づけをオン
syntax on
" バッファを保存しなくても他のバッファを表示できるようにする
set hidden
" コマンドライン補完を便利に
set wildmenu
" タイプ途中のコマンドを画面最下行に表示
set showcmd
" 検索語を強調表示（<C-L>を押すと現在の強調表示を解除する）
set hlsearch
" 歴史的にモードラインはセキュリティ上の脆弱性になっていたので、
" オフにして代わりに上記のsecuremodelinesスクリプトを使うとよい。
" set nomodeline
" 検索時に大文字・小文字を区別しない。ただし、検索後に大文字小文字が
" 混在しているときは区別する
set ignorecase
set smartcase
" オートインデント、改行、インサートモード開始直後にバックスペースキーで
" 削除できるようにする。
set backspace=indent,eol,start
" オートインデント
set autoindent
" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline
" 画面最下行にルーラーを表示する
set ruler
" ステータスラインを常に表示する
set laststatus=2
" バッファが変更されているとき、コマンドをエラーにするのでなく、保存する
" かどうか確認を求める
set confirm
" ビープの代わりにビジュアルベル（画面フラッシュ）を使う
set visualbell
" ビジュアルベルも無効化する
set t_vb=
" 全モードでマウスを有効化
set mouse=a
" "press <Enter> to continue"
" コマンドラインの高さを2行に
set cmdheight=4
" 行番号を表示
set number
" キーコードはすぐにタイムアウト。マッピングはタイムアウトしない
set notimeout ttimeout ttimeoutlen=200
" <F11>キーで'paste'と'nopaste'を切り替える
set pastetoggle=<F11>
" タブ文字の代わりにスペース2個を使う場合の設定。
" この場合、'tabstop'はデフォルトの8から変えない。
set shiftwidth=4
set softtabstop=4
set expandtab
" インデントにハードタブを使う場合の設定。
" タブ文字を2文字分の幅で表示する。
"set shiftwidth=2
"set tabstop=2
" Yの動作をDやCと同じにする
map Y y$
" <C-L>で検索後の強調表示を解除する
nnoremap <C-L> :nohl<CR><C-L>
" ビジュアルモードで選択したテキストが、クリップボードに入るようにする
" http://nanasi.jp/articles/howto/editing/clipboard.html
set clipboard=autoselect
 
" 無名レジスタに入るデータを、*レジスタにも入れる。
set clipboard+=unnamed

set clipboard=unnamedplus
" .swapファイルを作らない
set noswapfile
" 文字がない場所にもカーソルを移動できるようにする
"set virtualedit=all

" エンコーディングUTF-8に変更
set fileencoding=utf-8

" http://qiita.com/mitsuru793/items/2d464f30bd091f5d0fef
" *.rbの時のタブ幅を変更する
autocmd BufRead,BufNewfile *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufRead,BufNewfile *.yml setlocal tabstop=2 softtabstop=2 shiftwidth=2

" カラースキーマ変更
colorscheme apprentice
set t_Co=256
