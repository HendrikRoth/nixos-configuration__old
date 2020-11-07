{ config, pkgs, ... }:

let
    vim-svelte = pkgs.vimUtils.buildVimPlugin {
        name = "vim-svelte";
        src = pkgs.fetchFromGitHub {
            owner = "evanleck";
            repo = "vim-svelte";
            rev = "f63fa77d621b25092081cce815effd7fbc169113";
            sha256 = "0j7j6ibrylv32y0vw002yayfg7xia59nm2952bhbwlkl6m2cwnz9";
         };
         buildPhase = ":";
    };

    coc-svelte = pkgs.vimUtils.buildVimPlugin {
        name = "coc-svelte";
        src = pkgs.fetchFromGitHub {
            owner = "coc-extensions";
            repo = "coc-svelte";
            rev = "942857b2bd8318a770d2c5c63b2cd0c437a134e4";
            sha256 = "060kp555w4y9jc6jwyrc9wzdnj87j1gr90kx29kv6g83zm57d1f0";
        };
    };

    fzf-checkout = pkgs.vimUtils.buildVimPlugin {
        name = "fzf-checkout";
        src = pkgs.fetchFromGitHub {
            owner = "stsewd";
            repo = "fzf-checkout.vim";
            rev = "e9f8f6592ba04e3e2d31c64a77acc5a6bce012d8";
            sha256 = "09g08gsm7sjmnyfbydc8s4jfnrw8fk3qyjl7dd2bifm5w3kqk924";
        };
        buildPhase = ":";
    };

    tagalong = pkgs.vimUtils.buildVimPlugin {
        name = "tagalong";
        src = pkgs.fetchFromGitHub {
            owner = "AndrewRadev";
            repo = "tagalong.vim";
            rev = "02991180362687a2ecc9fa0ca97cd5f5fa4b223d";
            sha256 = "10lzbmpmw7sb6xh441y1j4262jhn40rbkrm4hgfp5rhvggvgj2nw";
        };
    };

in
{
    home.packages = with pkgs; [
        nodejs
        yarn
        nodePackages.typescript
    ];

    programs = {
        neovim = {
            enable = true;
            viAlias = true;
            vimAlias = true;
            withNodeJs = true;
            extraConfig = ''
                filetype plugin indent on
                syntax on
                set background=light
                set backspace=indent,eol,start
                set cmdheight=2
                set colorcolumn=80
                set clipboard=unnamed
                set expandtab
                set hidden
                set incsearch
                set nobackup
                set nocompatible
                set noshowmode
                set noswapfile
                set nowrap
                set nowritebackup
                set number
                set scrolloff=5
                set shiftwidth=4
                set shortmess+=c
                set smartcase
                set smartindent
                set tabstop=4 softtabstop=4
                set updatetime=300
                set updatetime=50
                set timeoutlen=100

                let mapleader = " "
                nnoremap <Space> <Nop>

                let g:lightline = {
                \  "colorscheme": "ayu_light",
                \  "active": {
                \    "left": [ [ "mode", "paste" ],
                \              [ "cocstatus", "gitbranch", "readonly", "filename", "modified" ] ]
                \  },
                \  "component_function": {
                \    "gitbranch": "gitbranch#name",
                \    "cocstatus": "coc#status"
                \  }
                \} 
                let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
                let $FZF_DEFAULT_OPTS = '--reverse'
                let g:calendar_google_calendar = 1
                let g:calendar_google_task = 1
                let g:floaterm_autoinsert = 1
                let g:floaterm_width = 0.8
                let g:floaterm_height = 0.8
                let g:floaterm_title = 0
                let g:floaterm_autoclose = 1
                let g:tagalong_filetypes = ['html', 'xml', 'jsx', 'ejs', 'javascriptreact', 'typescriptreact', 'javascript', 'svelte']
                let g:tagalong_verbose = 1
                let g:which_key_use_floating_win = 0
                let g:which_key_max_size = 0
                let g:which_key_map = {}
                let g:which_key_map['+'] = [':vertical resize +5', 'vertical resize +']
                let g:which_key_map['-'] = [':vertical resize -5', 'vertical resize -']
                let g:which_key_map['='] = ['<C-W>=', 'balance windows']
                let g:which_key_map['b'] = [':Buffers', 'search buffers']
                let g:which_key_map['C'] = [':Calendar -first_day=monday', 'calendar']
                let g:which_key_map['c'] = [':Commands', 'commands']
                let g:which_key_map['h'] = [':wincmd h', 'left window']
                let g:which_key_map['j'] = [':wincmd j', 'bottom window']
                let g:which_key_map['k'] = [':wincmd k', 'top window']
                let g:which_key_map['l'] = [':wincmd l', 'right window']
                let g:which_key_map['p'] = [':Files', 'search files']
                let g:which_key_map['q'] = [':q', 'quit']
                let g:which_key_map['s'] = ['<C-W>h', 'split below']
                let g:which_key_map['u'] = [':UndotreeToggle', 'undo tree']
                let g:which_key_map['v'] = ['<C-W>v', 'split right']
                let g:which_key_map['z'] = [':Goyo', 'distraction free']
                let g:which_key_map.f = {
                  \ 'name' : '+find & replace' ,
                  \ 'f' : [':Farr', 'file'],
                  \ 'p' : [':Farr', 'project'],
                  \ }
                let g:which_key_map.g = {
                  \ 'name': '+git',
                  \ 'a': [':Git add .', 'add all'],
                  \ 'b': [':GBranches', 'branches'],
                  \ 'c': [':Git commit', 'commit'],
                  \ 'C': [':Commits', 'commits'],
                  \ 'd': [':Git diff', 'diff'],
                  \ 'D': [':Gdiffsplit', 'diff split'],
                  \ 'f': [':Git fetch --all', 'fetch all'],
                  \ 's': [':Gstatus', 'status'],
                  \ 'p': [':Git push', 'push'],
                  \ 'P': [':Git pull', 'pull'],
                  \ 'r': [':GRemove', 'remove'],
                  \ }
                let g:which_key_map.s = {
                  \ 'name' : '+search' ,
                  \ '/' : [':History/'              , 'history'],
                  \ ';' : [':Commands'              , 'commands'],
                  \ 'a' : [':Ag'                    , 'text Ag'],
                  \ 'b' : [':BLines'                , 'current buffer'],
                  \ 'B' : [':Buffers'               , 'open buffers'],
                  \ 'c' : [':Commits'               , 'commits'],
                  \ 'C' : [':BCommits'              , 'buffer commits'],
                  \ 'f' : [':Files'                 , 'files'],
                  \ 'g' : [':GFiles'                , 'git files'],
                  \ 'G' : [':GFiles?'               , 'modified git files'],
                  \ 'h' : [':History'               , 'file history'],
                  \ 'H' : [':History:'              , 'command history'],
                  \ 'l' : [':Lines'                 , 'lines'] ,
                  \ 'm' : [':Marks'                 , 'marks'] ,
                  \ 'M' : [':Maps'                  , 'normal maps'] ,
                  \ 'p' : [':Helptags'              , 'help tags'] ,
                  \ 'P' : [':Tags'                  , 'project tags'],
                  \ 's' : [':CocList snippets'      , 'snippets'],
                  \ 'S' : [':Colors'                , 'color schemes'],
                  \ 't' : [':Rg'                    , 'text Rg'],
                  \ 'T' : [':BTags'                 , 'buffer tags'],
                  \ 'w' : [':Windows'               , 'search windows'],
                  \ 'y' : [':Filetypes'             , 'file types'],
                  \ 'z' : [':FZF'                   , 'FZF'],
                  \ }
                let g:which_key_map.t = {
                  \ 'name': '+terminal',
                  \ ';': [':FloatermNew --wintype=normal --height=6', 'terminal'],
                  \ 'f': [':FloatermNew fzf', 'fzf'],
                  \ 'g': [':FloatermNew lazygit', 'git'],
                  \ 'd': [':FloatermNew lazydocker', 'docker'],
                  \ 'n': [':FloatermNew nnn', 'nnn'],
                  \ 't': [':FloatermToggle', 'toggle'],
                  \ }

                autocmd User CocStatusChange,CocDiagnisticChange call lightline#update()
                autocmd VimEnter * call which_key#register('<Space>', "g:which_key_map")
                autocmd! FileType which_key
                autocmd  FileType which_key set laststatus=0 noshowmode noruler
                  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler
                " Goyo for mutt writing
                autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
                autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo
                autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
                autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

                nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
                nnoremap <silent> <TAB> :bnext<CR>
                nnoremap <silent> <S-TAB> :bprevious<CR>

                inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

                vnoremap < <gv
                vnoremap > >gv
                vnoremap <leader>p "_dP
                vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

                hi LineNr guifg=#969696 guibg=#f5f5f5f5 guisp=#f5f5f5 ctermfg=246 ctermbg=255
                hi ColorColumn ctermbg=255
            '';
            plugins = let
            in with pkgs.vimPlugins; [
                calendar-vim
                coc-fzf
                coc-json
                coc-nvim
                coc-svelte
                coc-tsserver
                coc-snippets
                coc-yaml
                editorconfig-vim
                far-vim
                fzf-checkout
                fzf-vim
                goyo-vim
                lightline-vim
                nerdcommenter
                open-browser-vim
                tagalong
                undotree
                vim-easy-align
                vim-easymotion
                vim-floaterm
                vim-fugitive
                vim-gitbranch
                vim-graphql
                vim-nix
                vim-sort-motion
                vim-startify
                vim-surround
                vim-svelte
                vim-which-key
            ];
        };
    };
}
