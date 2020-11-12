with import <nixpkgs> {};

let
  dmenu-kill-process = pkgs.writeShellScriptBin "dmenu-kill-process" ''
prompt="-p Process to kill:"
selected="$(ps -a -u $USER | ${pkgs.dmenu}/bin/dmenu $prompt | awk '{print $1" "$4}')"; 

if [[ ! -z $selected ]]; then
    answer="$(echo -e "Yes\nNo" | \
        ${pkgs.dmenu}/bin/dmenu -i -p "$selected will be killed, are you sure?")"

    if [[ $answer == "Yes" ]]; then
        selpid="$(awk '{print $1}' <<< $selected)"; 
        kill -9 $selpid
    fi
fi

exit 0
    '';

in
stdenv.mkDerivation rec {
  name = "test-environment";
  buildInputs = [ dmenu-kill-process ];
}
