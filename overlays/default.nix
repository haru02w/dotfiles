{inputs, ...}: {
  nur = inputs.nur.overlays.default;
  nixvim = final: prev: {
    neovim = inputs.self.packages.${final.system}.nixvim;
  };
}
