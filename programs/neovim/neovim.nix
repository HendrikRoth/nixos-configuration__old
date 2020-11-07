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

    vim-nnn = pkgs.vimUtils.buildVimPlugin {
        name = "vim-nnn";
        src = pkgs.fetchFromGitHub {
            owner = "mcchrish";
            repo = "nnn.vim";
            rev = "12a376646f05f71fb111892d07f84b94a47dbac5";
            sha256 = "1n746cw3lxq0jp062gz3cnfg4qb8zrprgxav5jmi1zp626w4b7xq";
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

                let g:mapleader = " "
                let g:maplocalleader = ","
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
                let g:nnn#layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
                let g:nnn#set_default_mappings = 0
                let g:calendar_google_calendar = 1
                let g:calendar_google_task = 1
                let g:floaterm_autoinsert = 1
                let g:floaterm_width = 0.8
                let g:floaterm_height = 0.8
                let g:floaterm_title = 0
                let g:floaterm_autoclose = 1
                let g:which_key_use_floating_win = 0
                let g:which_key_max_size = 0
                let g:which_key_map = {}
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

                nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
                nnoremap <leader>h :wincmd h<CR>
                nnoremap <leader>j :wincmd j<CR>
                nnoremap <leader>k :wincmd k<CR>
                nnoremap <leader>l :wincmd l<CR>
                nnoremap <leader>+ :vertical resize +5<CR>
                nnoremap <leader>- :vertical resize -5<CR>

                nnoremap <leader>p :Files<CR>
                nnoremap <leader>b :Buffers<CR>
                nnoremap <leader>u :UndotreeShow<CR>
                nnoremap <leader>n :NnnPicker %:p:h<CR>
                nnoremap <leader>c :Calendar -first_day=monday<CR>
                nnoremap <leader>f :Goyo \| set linebreak<CR>

                vnoremap <leader>p "_dP
                vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

                hi LineNr guifg=#969696 guibg=#f5f5f5f5 guisp=#f5f5f5 ctermfg=246 ctermbg=255
                hi ColorColumn ctermbg=255

                " Goyo for mutt writing
                autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
                autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo
                autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
                autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>
            '';
            plugins = let
            in with pkgs.vimPlugins; [
                calendar-vim
                coc-fzf
                coc-json
                coc-nvim
                coc-svelte
                coc-tsserver
                coc-yaml
                editorconfig-vim
                fzf-checkout
                fzf-vim
                goyo-vim
                lightline-vim
                nerdcommenter
                open-browser-vim
                undotree
                vim-easy-align
                vim-easymotion
                vim-floaterm
                vim-fugitive
                vim-gitbranch
                vim-graphql
                vim-nix
                vim-nnn
                vim-sort-motion
                vim-startify
                vim-surround
                vim-svelte
                vim-which-key
            ];
        };
    };
}
