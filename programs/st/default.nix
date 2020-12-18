{
  nixpkgs.config.st.patches = [
    ./1-xresources.diff
    #./1-anysize.diff
    #./2-scrollback.diff
    #./3-scrollback-mouse.diff
    #./4-xresources.diff
    #./5-clipboard.diff
    #./6-copyurl-highlight.diff
    #./7-w3m.diff
  ];
}
