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
        # OSD popup binary not in nixpkgs and has no binary cache; building it
        # from the flake means compiling. Disable to avoid the spawn crash loop.
        settings.osd.enabled = false;
        # Built-in evdev hotkey passes the key through to the focused app
        # (no exclusive grab), so the terminal sees Ctrl+F12 too. Use a niri
        # compositor keybind instead — it consumes the key and runs
        # `voxtype record toggle`.
        settings.hotkey.enabled = false;

        # No OSD popup (would need compiling). Use cheap indicators instead so
        # toggle-mode recording is never silently left on:
        #   - beep on start/stop
        #   - desktop notifications (shown by noctalia)
        settings.audio.feedback = {
          enabled = true;
          theme = "default";
        };
        settings.output.notification = {
          on_recording_start = true;
          on_recording_stop = true;
        };
      };
    };
}
