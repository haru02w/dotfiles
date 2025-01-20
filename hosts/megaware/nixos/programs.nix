{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure.customRC = ''
      set number relativenumber
    '';
  };
  environment.systemPackages = with pkgs; [
    neovim # text editor
    git # version control system
    wget # downloader
    sshfs # ssh fusemount
  ];
}
