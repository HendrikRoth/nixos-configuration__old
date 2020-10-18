{ config, pkgs, ... }:

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
                coc-nvim
                coc-tsserver
                coc-fzf
                coc-json
                coc-yaml
                lightline-vim
                fzf-vim
                vim-fugitive
                vim-surround
                vim-nix
                vim-which-key
            ];
        };
    };
}