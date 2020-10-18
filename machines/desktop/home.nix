{ config, pkgs, ...}:

{
    programs.home-manager.enable = true;

    imports = [
        ../../modules/neovim.nix
    ];

    home.file.".zshrc".source = ../../dotfiles/zshrc

    home.username = "hendrik";
    home.homeDirectory = "/home/hendrik";

    home.stateVersion = "20.09"
}