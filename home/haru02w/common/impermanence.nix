{ config, ... }: {
  home.persistence."/persist/${config.home.homeDirectory}" = {
    directories = [ "${config.home.homeDirectory}" ];
    allowOther = true;
  };
}
