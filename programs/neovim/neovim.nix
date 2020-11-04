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

    vim-iris = pkgs.vimUtils.buildVimPlugin {
        name = "iris-vim";
        src = pkgs.fetchFromGitHub {
            owner = "soywod";
            repo = "iris.vim";
            rev = "97e1e476c4b7a4e8a5db127599790dce8366c6ab";
            sha256 = "0rvdkdss33r4456bg7jhl250db2sjllljhgjgh080y0cmfr9djd8";
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
                set backspace=indent,eol,start
                set tabstop=4 softtabstop=4
                set shiftwidth=4
                set incsearch
                set hidden
                set expandtab
                set smartindent
                set smartcase
                set nobackup
                set nowritebackup
                set noswapfile
                set nowrap
                set cmdheight=2
                set scrolloff=5
                set updatetime=300
                set shortmess+=c
                set background=light
                set number
                set nocompatible
                set noshowmode
                set updatetime=50
                set colorcolumn=80
                highlight ColorColumn ctermbg=0 guibg=lightgrey

                let g:mapleader = " "
                let g:maplocalleader = ","
                let g:lightline = {
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

                autocmd User CocStatusChange,CocDiagnisticChange call lightline#update()

                nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
                nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
                nnoremap <leader>h :wincmd h<CR>
                nnoremap <leader>j :wincmd j<CR>
                nnoremap <leader>k :wincmd k<CR>
                nnoremap <leader>l :wincmd l<CR>
                nnoremap <leader>+ :vertical resize +5<CR>
                nnoremap <leader>- :vertical resize -5<CR>

                nnoremap <leader>p :Files<CR>
                nnoremap <leader>gc :GBranches<CR>
                nnoremap <leader>u :UndotreeShow<CR>
                nnoremap <leader>gf :Git fetch --all<CR>
                nnoremap <leader>n :NnnPicker %:p:h<CR>
                nnoremap <leader>c :Calendar -first_day=monday<CR>

                vnoremap <leader>p "_dP
            '';
            plugins = let
            in with pkgs.vimPlugins; [
                calendar-vim
                coc-nvim
                coc-svelte
                coc-tsserver
                coc-fzf
                coc-json
                coc-yaml
                editorconfig-vim
                lightline-vim
                fzf-vim
                fzf-checkout
                open-browser-vim
                vim-easymotion
                vim-easy-align
                vim-fugitive
                vim-gitbranch
                vim-graphql
                vim-iris
                vim-sort-motion
                vim-surround
                vim-svelte
                vim-nix
                vim-nnn
                undotree
                vim-which-key
            ];
        };
    };
}
