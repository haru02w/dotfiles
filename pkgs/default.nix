{
  inputs,
  pkgs,
  ...
}: {
  nixvim = inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
    inherit pkgs;
    module = inputs.self.outputs.nixvimModule;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
