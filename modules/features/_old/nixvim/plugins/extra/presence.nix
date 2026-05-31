{ den, ... }:
{
  den.aspects.nixvim.homeManager.programs.nixvim = {
    plugins.presence = {
      enable = true;
      settings.neovim_image_text = "Nixvim";
    };
  };
}
