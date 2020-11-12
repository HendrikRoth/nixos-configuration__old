with import <nixpkgs> {};

let
  dmenu-mail = pkgs.writeShellScriptBin "dmenu-mail" ''
text="$(echo | ${pkgs.dmenu}/bin/dmenu -p "Mail Text:")"
subject="$(echo | ${pkgs.dmenu}/bin/dmenu -p "Mail Subject:")"
address="$(echo | ${pkgs.dmenu}/bin/dmenu -p "Mail Address:")"

if [ $address != "" ]; then
    echo $text | ${pkgs.neomutt}/bin/neomutt -s $subject $address && notify-send "Mail sent to $address"
else
    ${pkgs.notify-send}/bin/notify-send "Mail" "You didn't insert any address."
fi

exit 0
    '';

in
stdenv.mkDerivation rec {
  name = "test-environment";
  buildInputs = [ dmenu-mail ];
}
