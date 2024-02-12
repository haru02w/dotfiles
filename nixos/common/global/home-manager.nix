# Doesn't enable home-manager, just configure it.
# To enable, `home-manager.users.${user} = {...}`
{ inputs, outputs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
  };
}
