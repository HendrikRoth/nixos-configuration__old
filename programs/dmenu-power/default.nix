{ pkgs }:

pkgs.writeShellScriptBin "dmenu-power" ''
  prompt="-p Action:"
  choices="Poweroff\nHibernate\nReboot"
  chosen="$(echo -e $choices | ${pkgs.dmenu}/bin/dmenu $prompt)"

  case "$chosen" in
      Poweroff) systemctl poweroff ;;
      Hibernate) systemctl hibernate ;;
      Reboot) systemctl reboot ;; 
  esac
''
