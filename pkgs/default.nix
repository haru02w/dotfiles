{
  inputs,
  pkgs,
  ...
}: {
  nixvim = inputs.nixvim.legacyPackages.${pkgs.stdenv.hostPlatform.system}.makeNixvimWithModule {
    inherit pkgs;
    module = inputs.self.outputs.nixvimModule;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
