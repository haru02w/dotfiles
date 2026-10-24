{ inputs, ... }:
let
  # Prebuilt CUDA packages (llama-cpp with cudaSupport isn't on cache.nixos.org).
  cudaCache = {
    extra-substituters = [ "https://cache.nixos-cuda.org" ];
    extra-trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };
in
{
  flake-file.nixConfig = cudaCache;
  flake-file.inputs.sweep-next-edit = {
    url = "file+https://huggingface.co/sweepai/sweep-next-edit-1.5B/resolve/main/sweep-next-edit-1.5b.q8_0.v2.gguf";
    flake = false;
  };

  # llama.cpp server running Sweep Next-Edit 1.5B for blink-edit.nvim
  # (next-edit predictions). Model: https://huggingface.co/sweepai/sweep-next-edit-1.5B
  den.aspects.llama-cpp.nixos =
    { pkgs, self', ... }:
    {
      nix.settings = cudaCache;

      nixvim.package = self'.packages.nixvim.extend { blink-edit.enable = true; };

      services.llama-cpp = {
        enable = true;
        package = pkgs.llama-cpp.override { cudaSupport = true; };
        settings = {
          model = "${inputs.sweep-next-edit}";
          # model id exposed on /v1/models, used by blink-edit's `llm.model`
          alias = "sweep";
          ctx-size = 8192;
          n-gpu-layers = 99;
          # Unload the model after 10 min without requests; it reloads on the
          # next one (i.e. when you start editing in Neovim again).
          sleep-idle-seconds = 600;
        };
      };
    };
}
