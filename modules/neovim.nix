{ config, pkgs, ... }:

let
    vim-vader = pkgs.vimUtils.buildVimPlugin {
        name = "vader.vim";
        src = pkgs.fetchFromGitHub {
          owner = "junegunn";
          repo = "vader.vim";
          rev = "6fff477431ac3191c69a3a5e5f187925466e275a";
          sha256 = "153cr1mrf5w5lyr8374brwx1z5yl9h0cnijxnd3xikh3yi3pbmwk";
        };
    };

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
                vim-vader
                coc-nvim
                coc-svelte
                coc-tsserver
                coc-fzf
                coc-json
                coc-yaml
                lightline-vim
                fzf-vim
                vim-fugitive
                vim-surround
                vim-svelte
                vim-nix
                vim-which-key
            ];
        };
    };
}
