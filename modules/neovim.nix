{ config, pkgs, ... }:

let
    vim-svelte = pkgs.vimUtils.buildVimPlugin {
        name = "vim-svelte";
        src = pkgs.fetchFromGitHub {
            owner = "evanleck";
            repo = "vim-svelte";
            rev = "f63fa77d621b25092081cce815effd7fbc169113";
            sha256 = "d98498f065a049541975a9c567e9d0b5514245117bef1d6ea77f924b7ef0a641";
        };
    };

    coc-svelte = pkgs.vimUtils.buildVimPlugin {
        name = "coc-svelte";
        src = pkgs.fetchFromGitHub {
            owner = "coc-extensions";
            repo = "coc-svelte";
            rev = "942857b2bd8318a770d2c5c63b2cd0c437a134e4";
            sha256 = "c8e015d9ee217f2849e9b0f572a50c74dfe4ad9be6bda144c74c1c117056bdec";
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
                coc-nvim
 #               coc-svelte
                coc-tsserver
                coc-fzf
                coc-json
                coc-yaml
                lightline-vim
                fzf-vim
                vim-fugitive
                vim-surround
#                vim-svelte
                vim-nix
                vim-which-key
            ];
        };
    };
}
