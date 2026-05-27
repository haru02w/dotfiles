{lib, ...}: {
  den.aspects.zsh = {
    darwin = {
      homebrew.enableZshIntegration = lib.mkDefault true;
      programs.direnv.enableZshIntegration = lib.mkDefault true;
    };
    nixos = {
      programs = {
        television.enableZshIntegration = lib.mkDefault true;
        foot.enableZshIntegration = lib.mkDefault true;
        atuin.enableZshIntegration = lib.mkDefault true;
        zoxide.enableZshIntegration = lib.mkDefault true;
        direnv.enableZshIntegration = lib.mkDefault true;
        nix-index.enableZshIntegration = lib.mkDefault true;
      };
    };
    homeManager = {
      home.shell.enableZshIntegration = lib.mkDefault true;
      programs = {
        eza.enableZshIntegration = lib.mkDefault true;
        lsd.enableZshIntegration = lib.mkDefault true;
        nnn.enableZshIntegration = lib.mkDefault true;
        pls.enableZshIntegration = lib.mkDefault true;
        eww.enableZshIntegration = lib.mkDefault true;
        fzf.enableZshIntegration = lib.mkDefault true;
        mods.enableZshIntegration = lib.mkDefault true;
        hstr.enableZshIntegration = lib.mkDefault true;
        mise.enableZshIntegration = lib.mkDefault true;
        goto.enableZshIntegration = lib.mkDefault true;
        pazi.enableZshIntegration = lib.mkDefault true;
        navi.enableZshIntegration = lib.mkDefault true;
        skim.enableZshIntegration = lib.mkDefault true;
        yazi.enableZshIntegration = lib.mkDefault true;
        opam.enableZshIntegration = lib.mkDefault true;
        broot.enableZshIntegration = lib.mkDefault true;
        mcfly.enableZshIntegration = lib.mkDefault true;
        rbenv.enableZshIntegration = lib.mkDefault true;
        aliae.enableZshIntegration = lib.mkDefault true;
        pyenv.enableZshIntegration = lib.mkDefault true;
        z-lua.enableZshIntegration = lib.mkDefault true;
        vivid.enableZshIntegration = lib.mkDefault true;
        atuin.enableZshIntegration = lib.mkDefault true;
        tirith.enableZshIntegration = lib.mkDefault true;
        zellij.enableZshIntegration = lib.mkDefault true;
        watson.enableZshIntegration = lib.mkDefault true;
        zoxide.enableZshIntegration = lib.mkDefault true;
        direnv.enableZshIntegration = lib.mkDefault true;
        lazygit.enableZshIntegration = lib.mkDefault true;
        wezterm.enableZshIntegration = lib.mkDefault true;
        granted.enableZshIntegration = lib.mkDefault true;
        ghostty.enableZshIntegration = lib.mkDefault true;
        sheldon.enableZshIntegration = lib.mkDefault true;
        scmpuff.enableZshIntegration = lib.mkDefault true;
        autojump.enableZshIntegration = lib.mkDefault true;
        starship.enableZshIntegration = lib.mkDefault true;
        keychain.enableZshIntegration = lib.mkDefault true;
        carapace.enableZshIntegration = lib.mkDefault true;
        kubecolor.enableZshIntegration = lib.mkDefault true;
        dircolors.enableZshIntegration = lib.mkDefault true;
        fabric-ai.enableZshIntegration = lib.mkDefault true;
        nix-index.enableZshIntegration = lib.mkDefault true;
        television.enableZshIntegration = lib.mkDefault true;
        oh-my-posh.enableZshIntegration = lib.mkDefault true;
        kubeswitch.enableZshIntegration = lib.mkDefault true;
        lazyworktree.enableZshIntegration = lib.mkDefault true;
        pay-respects.enableZshIntegration = lib.mkDefault true;
        intelli-shell.enableZshIntegration = lib.mkDefault true;
        nix-your-shell.enableZshIntegration = lib.mkDefault true;
        git-worktree-switcher.enableZshIntegration = lib.mkDefault true;
        kitty.shellIntegration.enableZshIntegration = lib.mkDefault true;
      };
      services = {
        clipcat.enableZshIntegration = lib.mkDefault true;
        gpg-agent.enableZshIntegration = lib.mkDefault true;
      };
    };
  };
}
