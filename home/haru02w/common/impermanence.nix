{ config, ... }: {
  home.persistence."/persist/${config.home.homeDirectory}" = {
    directories = [ ];
    allowOther = true;
  };
}
