{
  nixpkgs.config.dwm = {
    patches = [
      ./1-pertag.diff
      ./2-scratchpad.diff
      ./3-combo.diff
      ./4-centretitle.diff
      ./5-sticky.diff
      ./6-deck.diff
      ./7-columns.diff
    ];
    conf = builtins.readFile ./config.h;
  };
}
