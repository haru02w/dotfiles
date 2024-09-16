{ inputs, ... }: {
  imports = (builtins.attrValues inputs.self.outputs.homeModules);
  home.username = "haru02w";
  home.homeDirectory = "/home/haru02w";
  home.stateVersion = "24.05";
}
