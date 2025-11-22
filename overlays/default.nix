{inputs, ...}: {
  nur = inputs.nur.overlays.default;
  nixvim = final: prev: {
    inherit (inputs.self.packages.${final.stdenv.hostPlatform.system}) nixvim;
  };
}
