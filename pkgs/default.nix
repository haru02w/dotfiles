{
  inputs,
  pkgs,
  ...
}: {
  nixvim = inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
    inherit pkgs;
    module = import ./nixvim;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
