{...}:{
  imports = [ 
    ./hardware-configuration.nix 
    ./configuration.nix # temp
  ];
  modules.settings = {
    hostname = "inspiron";
    locale = "en_US.UTF-8";
    timezone = "America/Sao_Paulo";
  };
}
