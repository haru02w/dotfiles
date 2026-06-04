{ inputs, ... }:
{
  flake-file.inputs.voxtype = {
    url = "github:peteonrails/voxtype";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.voxtype.homeManager =
    { pkgs, ... }:
    {
      imports = [ inputs.voxtype.homeManagerModules.default ];
      home.packages = with pkgs; [
        wtype
      ];

      programs.voxtype = {
        enable = true;
        package = pkgs.voxtype-vulkan;
        service.enable = true;

        model.name = "medium";
        settings = {
          whisper = {
            language = [
              "en"
              "pt"
            ];
            eager_processing = true;
            flash_attention = true;
            context_window_optimization = true;
          };
          osd.enabled = false;
          hotkey.enabled = false;
          audio.feedback = {
            enabled = true;
            theme = "default";
          };
          output.notification = {
            on_recording_start = true;
            on_recording_stop = true;
          };
        };
      };
    };
}
