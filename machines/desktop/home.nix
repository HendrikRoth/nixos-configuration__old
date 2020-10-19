{ pkgs, ...}:

let
    # personal information
    name = "Hendrik Roth";
    mail = "hi@hendrikroth.com";
    username = "hendrik";
    githubUsername = "HendrikRoth";

    # paths
    homedir = "/home/hendrik/";
    dotfilesdir = "dotfiles";
    scriptsdir = "scripts";
    maildir = "mail";

in
{
    imports = [
        ../../modules/neovim.nix
    ];

    home.file.".zshrc".source = ../../dotfiles/zshrc

    home.username = "${username}";
    home.homeDirectory = "${homedir}";

    home.stateVersion = "20.09"

    accounts.email = {
        mailDirPath = "${homedir}${maildir}";
        accounts = {
            gmail = {
                address = "mail@henn1nk.com";
                userName = "mail@henn1nk.com";
                flavor = "gmail";
                mbsync = {
                    enable = true;
                    expunge = "both";
                    patterns = [ "*" "[!Gmail]*" "[Gmail/Sent Mail]" ];
                };
                realName = "${name}";
            };
            main = {
                address = "${email}";
                userName = "";
                flavor = "imap";
                mbsync = {
                    enable = true;
                    expunge = "both";
                    patterns = [ ];
                };
                realName = "${email}";
            };
        };
    };

    programs = {
        home-manager = {
            enable = true;
        };
        git = {
            userName = "${name}";
            userEmail = "${email}";
        };
    };
}