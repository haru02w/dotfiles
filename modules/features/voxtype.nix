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

        # Multilingual model (small, ~466 MB) with auto language detection —
        # handles Portuguese plus mixed pt/en.
        model.name = "small";
        settings = {
          whisper.language = "auto";
          # OSD popup binary not in nixpkgs and has no binary cache; building it
          # from the flake means compiling.
          # Use cheap indicators instead so
          # toggle-mode recording is never silently left on:
          #   - beep on start/stop
          #   - desktop notifications (shown by noctalia)
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
