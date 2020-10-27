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
        buildPhase = true;
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
                set hidden
                set nobackup
                set nowritebackup
                set noswapfile
                set cmdheight=2
                set updatetime=300
                set shortmess+=c
                set background=light
                set number
                set nocompatible

                let g:mapleader="\Space"
                let g:maplocalleader=","

                nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
                nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
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
                open-browser-vim
                vim-easymotion
                vim-easy-align
                vim-fugitive
                vim-graphql
                vim-sort-motion
                vim-surround
                vim-svelte
                vim-nix
                vim-which-key
            ];
        };
    };
}
