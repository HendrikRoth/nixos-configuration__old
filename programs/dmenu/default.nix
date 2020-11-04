{
  nixpkgs.config.dmenu.patches = [
    ./1-fuzzy.diff
    ./2-lineheight.diff
    ./3-xresources.diff
    ./4-highpriority.diff
  ];
}
