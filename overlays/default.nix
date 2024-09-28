{inputs, ...}: {
  nur = inputs.nur.overlay;
  nixvim = final: prev: {
    neovim = inputs.self.packages.${final.system}.nixvim;
  };
}
