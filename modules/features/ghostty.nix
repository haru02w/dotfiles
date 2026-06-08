{
  den.aspects.ghostty.homeManager = {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        gtk-single-instance = true;
        confirm-close-surface = false;
        cursor-style = "block";
        shell-integration-features = "no-cursor";
      };
    };
  };
}
