{ pkgs }:

pkgs.writeShellScriptBin "dmenu-scrot" ''
  imageFolder=${HOME}/Images/Scrots
  cmdOptions="
    Fullscreen
    Section
    Fullscreen saved
    Section saved
    Fullscreen uploaded
    Section uploaded
  "

  cmd=$(${pkgs.dmenu}/bin/dmenu -l 10 -p 'Screenshot:' <<< "$cmdOptions")
  filename='%Y-%m-%d-@%H-%M-%S-scrot.png'

  case ${cmd%% *} in
      Fullscreen) ${pkgs.scrot}/bin/scrot -d 1 $filename ;;
      Section) ${pkgs.scrot}/bin/scrot -s $filename ;;
      Fullscreen saved) ${pkgs.scrot}/bin/scrot -d 1 $filename ;;
      Section saved) ${pkgs.scrot}/bin/scrot -s $filename ;;
      Fullscreen uploaded) ${pkgs.scrot}/bin/scrot -d 1 $filename -e imgurbash2 ;;
      Section uploaded) ${pkgs.scrot}/bin/scrot -s $filename -e imgurbash2 ;;
      *) exec "'${cmd}'" ;;
  esac
''
