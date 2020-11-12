with import <nixpkgs> {};

let
  dmenu-power = pkgs.writeShellScriptBin "dmenu-power" ''
prompt="-p Action:"
choices="Poweroff\nHibernate\nReboot"
chosen="$(echo -e $choices | ${pkgs.dmenu}/bin/dmenu $prompt)"

case "$chosen" in
	Poweroff) systemctl poweroff ;;
    Hibernate) systemctl hibernate ;;
	Reboot) systemctl reboot ;; 
esac
    '';

in
stdenv.mkDerivation rec {
  name = "test-environment";
  buildInputs = [ dmenu-power ];
}
