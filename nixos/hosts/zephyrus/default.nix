{outputs, ...}:{
  imports = [
    (builtins.attrValues outputs.nixosModules)
    ./disko.nix
    ./hardware-configuration.nix
    ../common/global
  ];
  
}
